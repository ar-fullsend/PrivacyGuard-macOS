import AVFoundation
import CoreMedia

class MacCameraSensor: NSObject {
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var isRunning = false
    
    weak var delegate: MacCameraSensorDelegate?
    
    override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        guard let device = AVCaptureDevice.default(for: .video) else {
            print("No video device (webcam) available")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
            
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
        } catch {
            print("Error setting up Mac camera: \(error)")
        }
    }
    
    func start() {
        guard !isRunning else { return }
        captureSession.startRunning()
        isRunning = true
        print("Mac webcam started")
    }
    
    func stop() {
        guard isRunning else { return }
        captureSession.stopRunning()
        isRunning = false
        print("Mac webcam stopped")
    }
}

extension MacCameraSensor: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        delegate?.didCaptureFrame(pixelBuffer: pixelBuffer)
    }
}

protocol MacCameraSensorDelegate: AnyObject {
    func didCaptureFrame(pixelBuffer: CVPixelBuffer)
}