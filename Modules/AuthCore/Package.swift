// swift-tools-version:6.1
import PackageDescription

let package = Package(
    name: "AuthCore",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "AuthCore",
            targets: ["AuthCore"]
        )
    ],
    targets: [
        .target(
            name: "AuthCore",
            path: "Sources"
        ),
        .testTarget(
            name: "AuthCoreTests",
            dependencies: ["AuthCore"],
            path: "Tests/AuthCoreTests"
        )
    ]
)
