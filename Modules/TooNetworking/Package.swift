// swift-tools-version:5.9
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
    targets: [
        .target(
            name: "TooNetworking",
            path: "Sources"
        ),
        .testTarget(
            name: "TooNetworkingTests",
            dependencies: ["TooNetworking"],
            path: "Tests/TooNetworkingTests"
        )
    ]
)
