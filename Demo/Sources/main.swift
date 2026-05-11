import Foundation
import PrivacyGuard

print("PrivacyGuard macOS Demo - Real-time webcam face detection")
print("Press Enter to start monitoring, Ctrl+C to stop.")

let manager = PrivacyGuardManager.shared

// Simple CLI loop
while true {
    print("\nEnter 'start' to begin, 'stop' to end, or 'quit': ", terminator: "")
    if let input = readLine()?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) {
        if input == "start" {
            manager.startMonitoring()
            print("Monitoring active - point webcam at yourself + second person to trigger shield.")
        } else if input == "stop" {
            manager.stopMonitoring()
            print("Monitoring stopped.")
        } else if input == "quit" {
            manager.stopMonitoring()
            print("Exiting.")
            break
        } else {
            print("Unknown command.")
        }
    }
}