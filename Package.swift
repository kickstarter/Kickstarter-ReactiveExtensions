// swift-tools-version:5.5
import PackageDescription

let package = Package(
  name: "ReactiveExtensions",
  platforms: [
    .iOS(.v14),
    .tvOS(.v14)
  ],
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
    .package(name: "ReactiveSwift", url: "https://github.com/ReactiveCocoa/ReactiveSwift",
      .upToNextMajor(from: "7.1.1"))
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
