import SwiftUI
import AVFoundation
import PrivacyGuard

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var isMonitoring = false
    @State private var statusText = "Ready to protect your screen"
    @State private var faceCount = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // Camera Preview
            CameraPreview(session: cameraManager.session)
                .frame(height: 400)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.blue.opacity(0.3), lineWidth: 2)
                )
            
            // Status
            Text(statusText)
                .font(.title2)
                .foregroundColor(isMonitoring ? .green : .secondary)
                .multilineTextAlignment(.center)
            
            if faceCount > 1 {
                Text("⚠️ Multiple faces detected — Shield active")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            
            // Controls
            HStack(spacing: 16) {
                Button(isMonitoring ? "Stop Monitoring" : "Start Monitoring") {
                    if isMonitoring {
                        cameraManager.stop()
                        PrivacyGuardManager.shared.stopMonitoring()
                        isMonitoring = false
                        statusText = "Monitoring stopped"
                    } else {
                        cameraManager.start()
                        PrivacyGuardManager.shared.startMonitoring()
                        isMonitoring = true
                        statusText = "Monitoring active — Shield will activate on second face"
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(isMonitoring ? .red : .blue)
                .controlSize(.large)
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                .buttonStyle(.bordered)
            }
            
            Text("PrivacyGuard macOS • On-device • Real-time")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(40)
        .frame(minWidth: 600, minHeight: 700)
        .onAppear {
            cameraManager.setup()
        }
    }
}

// Simple Camera Preview using AVCaptureVideoPreviewLayer
struct CameraPreview: NSViewRepresentable {
    let session: AVCaptureSession
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer = previewLayer
        view.wantsLayer = true
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        if let previewLayer = nsView.layer as? AVCaptureVideoPreviewLayer {
            previewLayer.session = session
        }
    }
}

class CameraManager: ObservableObject {
    let session = AVCaptureSession()
    private var isRunning = false
    
    func setup() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            let output = AVCaptureVideoDataOutput()
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
        } catch {
            print("Camera setup error: \(error)")
        }
    }
    
    func start() {
        guard !isRunning else { return }
        session.startRunning()
        isRunning = true
    }
    
    func stop() {
        guard isRunning else { return }
        session.stopRunning()
        isRunning = false
    }
}