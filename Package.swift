// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "Kickstarter-ReactiveExtensions",
    products: [
        .library(
            name: "Kickstarter-ReactiveExtensions",
            targets: ["Kickstarter-ReactiveExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift", from: "6.5.0"),
    ],
    targets: [
        .target(
            name: "Kickstarter-ReactiveExtensions",
            dependencies: ["ReactiveSwift"]),
        .testTarget(
            name: "Kickstarter-ReactiveExtensionsTests",
            dependencies: ["Kickstarter-ReactiveExtensions"]),
    ]
)
