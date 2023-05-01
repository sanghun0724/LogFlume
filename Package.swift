//
//  Package.swift
//  LogFlume
//
//  Created by sangheon on 2023/05/01.
//

import PackageDescription

let package = Package(
    platforms: [.iOS(.v13)],
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

