// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "WhatsNewKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "WhatsNewKit",
            targets: ["WhatsNewKit"]
        ),
        .library(
            name: "WhatsNewKitSwiftUI",
            targets: ["WhatsNewKitSwiftUI"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WhatsNewKit",
            path: "Sources",
            exclude: ["SwiftUI"]
        ),
        .target(
            name: "WhatsNewKitSwiftUI",
            dependencies: ["WhatsNewKit"],
            path: "Sources",
            sources: ["SwiftUI"]
        ),
        .testTarget(
            name: "WhatsNewKitTests",
            dependencies: ["WhatsNewKit"],
            path: "Tests"
        ),
    ]
)
