// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MRSignMTKit",
    platforms: [
        .iOS(.v17),
        .visionOS("2.0")
    ],
    products: [
        .library(
            name: "MRSignMTKit",
            targets: ["MRSignMTKit"]),
    ],
    dependencies: [
        .package(path: "../src/MRSignMTArchitecture")//,
//        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.10.0"),
//        .package(url: "https://github.com/tensorflow/tensorflow.git", from: "2.19.0")
    ],
    targets: [
        .target(
            name: "MRSignMTKit"),
        .testTarget(
            name: "MRSignMTKitTests",
            dependencies: ["MRSignMTKit"]
        ),
    ]
)
