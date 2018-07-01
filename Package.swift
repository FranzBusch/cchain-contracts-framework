// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CChain",
    products: [
        .library(
            name: "cchain-contracts-framework",
            targets: ["cchain-contracts-framework"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "cchain-contracts-framework",
            dependencies: ["Vapor", "JWT", "CryptoSwift"]),
        .testTarget(
            name: "cchain-contracts-frameworkTests",
            dependencies: ["cchain-contracts-framework"]),
    ]
)
