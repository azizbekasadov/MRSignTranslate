// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MRSignMTArchitecture",
    platforms: [
        .iOS(.v17),
        .macOS(.v11),
        .watchOS(.v6),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "MRSignMTArchitecture",
            targets: ["MRSignMTArchitecture"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.6.2")
    ],
    targets: [
        .target(
            name: "MRSignMTArchitecture",
            dependencies: [
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "MRSignMTArchitectureTests",
            dependencies: [
                .target(name: "MRSignMTArchitecture")
            ],
            swiftSettings: [.unsafeFlags(["-Xfrontend", "-enable-testing"])]
        )
        
    ]
)
