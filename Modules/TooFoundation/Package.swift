// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TooFoundation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "TooFoundation",
            targets: ["TooFoundation"]
        )
    ],
    targets: [
        .target(
            name: "TooFoundation",
            path: "Sources"
        ),
        .testTarget(
            name: "TooFoundationTests",
            dependencies: ["TooFoundation"],
            path: "Tests/TooFoundationTests"
        )
    ]
)
