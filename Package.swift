// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "WolfFoundation",
    products: [
        .library(
            name: "WolfFoundation",
            targets: ["WolfFoundation"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "3.0.1"),
        .package(url: "https://github.com/wolfmcnally/WolfPipe", from: "1.1.1"),
    ],
    targets: [
        .target(
            name: "WolfFoundation",
            dependencies: ["WolfNumerics", "WolfPipe"])
        ]
)
