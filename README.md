# PrivacyGuard-macOS

**Your screen. Yours alone. (macOS Edition)**

Real-time second-face detection for macOS using built-in or external web cameras. Triggers an in-app privacy shield overlay when multiple faces are detected. Built with AVFoundation (camera) + Vision (on-device face detection).

## Quick Start (Xcode)

1. Clone the repo
2. Open the folder in Xcode (File > Open... or double-click Package.swift)
3. Select the MacApp scheme and run on your Mac

Or run the CLI demo:
```bash
swift run PrivacyGuardDemo
```

## Features
- Live camera preview
- One-tap start/stop monitoring
- Automatic shield on second face detection
- 100% on-device (no cloud)

## Requirements
- macOS 14+ (Sonoma or later)
- Built-in or USB webcam
- Camera permission (first run)

## Project Structure
- `ProofOfConcept/` — Core library
- `MacApp/` — Native SwiftUI macOS app (Xcode-ready)
- `Demo/` — CLI version

MIT License — privacy-first desktop protection.