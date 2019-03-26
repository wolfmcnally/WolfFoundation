// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfFoundation",
    products: [
        .library(
            name: "WolfFoundation",
            targets: ["WolfFoundation"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfNumerics", from: "4.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfPipe", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "WolfFoundation",
            dependencies: ["WolfNumerics", "WolfPipe"])
        ]
)
