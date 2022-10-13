// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ReactiveExtensions",
  products: [
    .library(
      name: "ReactiveExtensions",
      targets: ["ReactiveExtensions"]
    ),
    .library(
      name: "ReactiveExtensions-TestHelpers",
      targets: ["ReactiveExtensions-TestHelpers"]
    )
  ],
  dependencies: [
    .package(name: "ReactiveSwift", url: "https://github.com/ReactiveCocoa/ReactiveSwift", .exact("6.5.0")),
    .package(name: "Foundation")
      ],
  targets: [
    .target(name: "ReactiveExtensions", dependencies: ["ReactiveSwift"],
            linkerSettings: [
                .linkedFramework("Foundation")
            ]),
    .testTarget(
      name: "ReactiveExtensions-iOSTests",
      dependencies: ["ReactiveExtensions", "ReactiveExtensions-TestHelpers"],
      path: "Tests"
    ),
    .target(name: "ReactiveExtensions-TestHelpers", dependencies: ["ReactiveSwift"],
            linkerSettings: [
                .linkedFramework("Foundation")
            ])
  ]
)
