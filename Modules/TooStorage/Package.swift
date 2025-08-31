// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "TooStorage",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "TooStorage",
            targets: ["TooStorage"]
        )
    ],
    targets: [
        .target(
            name: "TooStorage",
            path: "Sources"
        ),
        .testTarget(
            name: "TooStorageTests",
            dependencies: ["TooStorage"],
            path: "Tests/TooStorageTests"
        )
    ]
)
