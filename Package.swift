// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "PrivacyGuard-macOS",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "PrivacyGuard",
            targets: ["PrivacyGuard"]
        ),
        .executable(
            name: "PrivacyGuardDemo",
            targets: ["PrivacyGuardDemo"]
        )
    ],
    targets: [
        .target(
            name: "PrivacyGuard",
            dependencies: [],
            path: "ProofOfConcept"
        ),
        .executableTarget(
            name: "PrivacyGuardDemo",
            dependencies: ["PrivacyGuard"],
            path: "Demo"
        ),
        .testTarget(
            name: "PrivacyGuardTests",
            dependencies: ["PrivacyGuard"],
            path: "Tests/PrivacyGuardTests"
        )
    ]
)