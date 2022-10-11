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
  targets: [
    .target(name: "ReactiveExtensions-iOS"),
    .testTarget(
      name: "ReactiveExtensions-iOSTests",
      dependencies: ["ReactiveExtensions-iOS", "ReactiveExtensions-TestHelpers-iOS"],
      path: "ReactiveExtensions/tests"
    ),
    .target(name: "ReactiveExtensions-TestHelpers-iOS")
  ]
)
