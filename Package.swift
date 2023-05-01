// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LogFlume",
    products: [
        .library(name: "LogFlume", targets: ["LogFlume"])
    ],
    targets: [
        .target(name: "LogFlume", path: "Sources"),
        .testTarget(name: "LogFlumeTests", dependencies: ["LogFlume"]),
    ],
    swiftLanguageVersions: [.v5]
)

