// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ReactiveExtensions",
  products: [
    .library(
      name: "ReactiveExtensions",
      targets: ["ReactiveExtensions-iOS"]
    ),
    .library(
      name: "ReactiveExtensions-TestHelpers",
      targets: ["ReactiveExtensions-TestHelpers-iOS"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift", from: "6.5.0")
      ],
  targets: [
    .target(name: "ReactiveExtensions-iOS", dependencies: ["ReactiveSwift"]),
    .testTarget(
      name: "ReactiveExtensions-iOSTests",
      dependencies: ["ReactiveExtensions-iOS", "ReactiveExtensions-TestHelpers-iOS"],
      path: "Tests"
    ),
    .target(name: "ReactiveExtensions-TestHelpers-iOS", dependencies: ["ReactiveSwift"])
  ]
)
