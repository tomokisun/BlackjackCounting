// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BlackjackCountingCore",
  platforms: [
    .iOS(.v16),
    .macOS(.v13),
    .watchOS(.v9),
    .tvOS(.v16)
  ],
  products: [
    .library(name: "BlackjackCountingCore", targets: ["BlackjackCounting"]),
    .library(name: "Analytics", targets: ["Analytics"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.54.0"),
    .package(url: "https://github.com/tomokisun/PokerHands", branch: "master"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "10.8.0"),
  ],
  targets: [
    .target(
      name: "BlackjackCounting",
      dependencies: [
        "Analytics",
        .product(name: "PokerHands", package: "PokerHands"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "BlackjackCountingTests",
      dependencies: [
        "BlackjackCounting"
      ]
    ),
    .target(
      name: "Analytics",
      dependencies: [
        .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
  ]
)
