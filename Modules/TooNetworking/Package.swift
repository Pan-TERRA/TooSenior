// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "TooNetworking",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "TooNetworking",
            targets: ["TooNetworking"]
        )
    ],
    dependencies: [
        .package(path: "../TooFoundation")
    ],
    targets: [
        .target(
            name: "TooNetworking",
            dependencies: ["TooFoundation"],
            path: "Sources"
        ),
        .testTarget(
            name: "TooNetworkingTests",
            dependencies: ["TooNetworking"],
            path: "Tests/TooNetworkingTests"
        )
    ]
)
