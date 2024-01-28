// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "XcodeThemeConvertor",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "XcodeTheme", targets: ["XcodeTheme"]),
        .executable(name: "convertor", targets: ["Convertor"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danielctull/FileBuilder", branch: "main"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
    ],
    targets: [

        .target(name: "XcodeTheme"),

        .testTarget(
            name: "XcodeThemeTests",
            dependencies: [
                "XcodeTheme"
            ],
            resources: [
                .process("Resources"),
            ]),

        .executableTarget(
            name: "Convertor",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "FileBuilder",
                "XcodeTheme",
            ]
        ),
    ]
)
