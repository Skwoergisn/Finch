// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
            .macOS(.v13)
        ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Core",
            targets: ["Parser", "Inspector"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.9"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Parser",
            dependencies: ["Inspector"]),
        .target(
            name: "Inspector",
            dependencies: [
                .product(name: "ZIPFoundation", package: "ZIPFoundation")
            ]),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Parser"]),
    ]
)
