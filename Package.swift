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
    ),
    .library(
      name: "ReactiveExtensions-tvOS",
      targets: ["ReactiveExtensions-tvOS"]
    ),
    .library(
      name: "ReactiveExtensions-TestHelpers-tvOS",
      targets: ["ReactiveExtensions-TestHelpers-tvOS"]
    )
  ],
  dependencies: [
    .package(name: "ReactiveSwift", url: "https://github.com/ReactiveCocoa/ReactiveSwift", .exact("7.1.1"))
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
            ]),
    .target(name: "ReactiveExtensions-tvOS", dependencies: ["ReactiveSwift"],
            linkerSettings: [
                .linkedFramework("Foundation")
            ]),
    .testTarget(
      name: "ReactiveExtensions-tvOSTests",
      dependencies: ["ReactiveExtensions-tvOS", "ReactiveExtensions-TestHelpers-tvOS"],
      path: "Tests"
    ),
    .target(name: "ReactiveExtensions-TestHelpers-tvOS", dependencies: ["ReactiveSwift"],
            linkerSettings: [
                .linkedFramework("Foundation")
            ])
  ]
)
