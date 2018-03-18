//
//  DeepstreamIO.swift
//  DeepstreamIO
//
//  Created by Satish Babariya on 23/10/15.
//  Copyright © 2017 satishbabariya. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "DeepstreamIO",
    products: [
        .library(name: "DeepstreamIO", targets: ["DeepstreamIO"])
    ],
    dependencies: [
        .package(url: "https://github.com/daltoniam/Starscream", .upToNextMinor(from: "3.0.0")),
    ],
    targets: [
        .target(name: "DeepstreamIO", dependencies: ["Starscream"]),
        .testTarget(name: "TestDeepstreamIO", dependencies: ["DeepstreamIO"]),
    ]
)
