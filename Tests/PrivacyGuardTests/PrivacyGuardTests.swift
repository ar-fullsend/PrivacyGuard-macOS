import XCTest
@testable import PrivacyGuard

final class PrivacyGuardTests: XCTestCase {
    @MainActor
    func testPrivacyGuardManagerExists() throws {
        let manager = PrivacyGuardManager.shared
        manager.startMonitoring()
        manager.stopMonitoring()
        // Basic smoke test passes if no crash
    }
}