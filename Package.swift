// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CChainContracts",
    products: [
        .library(
            name: "CChainContracts",
            targets: ["CChainContracts"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/jwt.git", from: "3.0.0-rc"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "0.9.0")
    ],
    targets: [
        .target(
            name: "CChainContracts",
            dependencies: ["Vapor", "JWT", "CryptoSwift"]),
        .testTarget(
            name: "cchain-contracts-frameworkTests",
            dependencies: ["cchain-contracts-framework"]),
    ]
)
