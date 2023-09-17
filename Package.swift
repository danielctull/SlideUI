// swift-tools-version:5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "SlideUI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "SlideUI",
            targets: ["SlideUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", branch: "main"),
        .package(url: "https://github.com/apple/swift-format", branch: "main"),
    ],
    targets: [

        .target(
            name: "SlideUI",
            dependencies: [
                "SlideUIMacros",
                .product(name: "SwiftIDEUtils", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftParser", package: "swift-syntax"),
            ]),

        .testTarget(
            name: "SlideUITests",
            dependencies: [
                "SlideUI",
            ]),

        .macro(
            name: "SlideUIMacros",
            dependencies: [
                .product(name: "SwiftFormat", package: "swift-format"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]),
    ]
)
