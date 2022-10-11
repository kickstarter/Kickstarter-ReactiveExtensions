// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ReactiveExtensions",
  products: [
    .library(
      name: "ReactiveExtensions-iOS",
      targets: ["ReactiveExtensions-iOS"]
    ),
    .library(
      name: "ReactiveExtensions-TestHelpers-iOS",
      targets: ["ReactiveExtensions-TestHelpers-iOS"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift", from: "6.5.0")
      ],
  targets: [
    .target(name: "ReactiveExtensions-iOS"),
    .testTarget(
      name: "ReactiveExtensions-iOSTests",
      dependencies: ["ReactiveExtensions-iOS", "ReactiveExtensions-TestHelpers-iOS"],
      path: "Tests"
    ),
    .target(name: "ReactiveExtensions-TestHelpers-iOS")
  ]
)
