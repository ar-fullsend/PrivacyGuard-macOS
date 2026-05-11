# PrivacyGuard-macOS

**Your screen. Yours alone. (macOS Edition)**

Real-time second-face detection for macOS using built-in or external web cameras. Triggers an in-app privacy shield overlay when multiple faces are detected. Built with AVFoundation (camera) + Vision (on-device face detection).

## Quick Start

```bash
git clone https://github.com/ar-fullsend/PrivacyGuard-macOS.git
cd PrivacyGuard-macOS
swift run PrivacyGuardDemo
```

- Type `start` to begin webcam monitoring.
- Point camera at yourself + a second face/object to activate shield.
- Type `stop` or `quit` to end.

## How It Works

1. **Capture** — AVFoundation grabs frames from default video device (webcam).
2. **Detect** — Vision framework counts faces in real time (<100ms).
3. **Shield** — NSWindow overlay activates on >1 face.
4. **Restore** — Overlay disappears instantly when single face remains.

## Project Structure

- `ProofOfConcept/` — Core library (MacCameraSensor, VisionDetector, PrivacyGuardManager, ShieldOverlay)
- `Demo/` — CLI executable for testing
- `Package.swift` — SwiftPM for macOS 14+

## Requirements

- macOS 14+ (Sonoma or later)
- Built-in or USB webcam
- Camera permission (granted on first run)

## Future

- Full SwiftUI desktop app with live preview
- System-wide overlay (requires Screen Recording permission + private APIs)
- Integration with macOS privacy features

MIT License — privacy-first desktop protection.