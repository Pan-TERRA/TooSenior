// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "OnboardingUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "OnboardingUI",
            targets: ["OnboardingUI"]
        )
    ],
    targets: [
        .target(
            name: "OnboardingUI",
            path: "Sources"
        ),
        .testTarget(
            name: "OnboardingUITests",
            dependencies: ["OnboardingUI"],
            path: "Tests/OnboardingUITests"
        )
    ]
)
