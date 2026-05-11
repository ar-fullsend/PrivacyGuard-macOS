import Vision
import CoreVideo

class VisionDetector {
    private let faceDetectionRequest = VNDetectFaceRectanglesRequest()
    
    func detectFaces(in pixelBuffer: CVPixelBuffer) -> Int {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        
        do {
            try handler.perform([faceDetectionRequest])
            if let results = faceDetectionRequest.results {
                return results.count
            } else {
                return 0
            }
        } catch {
            print("Vision error: \(error)")
            return 0
        }
    }
}