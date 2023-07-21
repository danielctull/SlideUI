// swift-tools-version:5.7

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
    targets: [

        .target(
            name: "SlideUI"),

        .testTarget(
            name: "SlideUITests",
            dependencies: [
                "SlideUI"
            ]),
    ]
)
