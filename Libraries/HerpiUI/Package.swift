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
        .package(path: "../HerpiFoundation")
    ],
    targets: [
        .target(
            name: "HerpiUI",
            dependencies: [
                .product(name: "HerpiFoundation", package: "HerpiFoundation")
            ]
        )
    ]
)
