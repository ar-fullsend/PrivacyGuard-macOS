import Foundation
import Vision
import AppKit

public class PrivacyGuardManager {
    @MainActor public static let shared = PrivacyGuardManager()
    
    private var isActive = false
    private var currentFaceCount = 1
    private var sensor: MacCameraSensor?
    private var visionDetector: VisionDetector?
    
    private init() {
        sensor = MacCameraSensor()
        visionDetector = VisionDetector()
        sensor?.delegate = self
    }
    
    @MainActor
    public func startMonitoring() {
        isActive = true
        sensor?.start()
    }
    
    @MainActor
    public func stopMonitoring() {
        isActive = false
        sensor?.stop()
    }
    
    @MainActor
    private func handleFaceCount(_ count: Int) {
        currentFaceCount = count
        if count > 1 {
            ShieldOverlay.activate()
        } else {
            ShieldOverlay.deactivate()
        }
    }
}

extension PrivacyGuardManager: MacCameraSensorDelegate {
    nonisolated func didCaptureFrame(pixelBuffer: CVPixelBuffer) {
        guard let visionDetector = visionDetector else { return }
        let faceCount = visionDetector.detectFaces(in: pixelBuffer)
        Task { @MainActor in
            PrivacyGuardManager.shared.handleFaceCount(faceCount)
        }
    }
}