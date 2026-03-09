// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HerpiUI",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "HerpiUI",
            targets: ["HerpiUI"]),
    ],
    dependencies: [
        .package(path: "../HerpiFoundation"),
        .package(url: "https://github.com/onevcat/Kingfisher", from: "8.0.0")
    ],
    targets: [
        .target(
            name: "HerpiUI",
            dependencies: [
                .product(name: "HerpiFoundation", package: "HerpiFoundation"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
        )
    ]
)
