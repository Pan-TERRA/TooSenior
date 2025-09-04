// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "FeedKitCore",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "FeedKitCore",
            targets: ["FeedKitCore"]
        )
    ],
    dependencies: [
        .package(path: "../TooFoundation"),
        .package(path: "../TooNetworking")
    ],
    targets: [
        .target(
            name: "FeedKitCore",
            dependencies: ["TooFoundation", "TooNetworking"],
            path: "Sources"
        ),
        .testTarget(
            name: "FeedKitCoreTests",
            dependencies: ["FeedKitCore"],
            path: "Tests/FeedKitCoreTests"
        )
    ]
)
