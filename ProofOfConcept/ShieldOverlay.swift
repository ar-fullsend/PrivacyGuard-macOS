import AppKit

@MainActor
class ShieldOverlay {
    private static var overlayWindow: NSWindow?
    
    static func activate() {
        print("🛡️ Shield activated - Screen protected (macOS)")
        
        let window = NSWindow(
            contentRect: NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 800, height: 600),
            styleMask: [.borderless],
            backing: .buffered,
            defer: false
        )
        window.backgroundColor = NSColor.black.withAlphaComponent(0.85)
        window.level = .floating
        window.isOpaque = false
        window.ignoresMouseEvents = true
        window.makeKeyAndOrderFront(nil)
        
        let label = NSTextField(labelWithString: "PRIVACY SHIELD ACTIVE\nSecond face detected - Screen secured")
        label.textColor = .white
        label.font = NSFont.boldSystemFont(ofSize: 28)
        label.alignment = .center
        label.isBezeled = false
        label.drawsBackground = false
        
        window.contentView?.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: window.contentView!.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: window.contentView!.centerYAnchor)
        ])
        
        overlayWindow = window
    }
    
    static func deactivate() {
        print("✅ Shield deactivated - Normal view restored (macOS)")
        overlayWindow?.orderOut(nil)
        overlayWindow = nil
    }
}