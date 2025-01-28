// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnmoggableUI",
    platforms: [
            .iOS(.v17) // Ensure this is set to at least iOS 13.0
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UnmoggableUI",
            targets: ["UnmoggableUI"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "UnmoggableUI"),
        .testTarget(
            name: "UnmoggableUITests",
            dependencies: ["UnmoggableUI"]
        ),
    ]
)
