// swift-tools-version:5.10

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "SlideUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "SlideUI",
            targets: ["SlideUI"]),

        .library(
            name: "XcodeCodeHighlighting",
            targets: ["XcodeCodeHighlighting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax", from: "510.0.0"),
        .package(url: "https://github.com/apple/swift-format", from: "510.0.0"),
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


        .executableTarget(
            name: "SlideUI Demo",
            dependencies: [
                "SlideUI",
                "XcodeCodeHighlighting",
            ]
        ),

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

        .target(
            name: "XcodeCodeHighlighting",
            dependencies: [
                "SlideUI",
            ]),
    ]
)
