// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WolfFoundation",
    platforms: [
        .iOS(.v9), .macOS(.v10_13), .tvOS(.v11)
    ],
    products: [
        .library(
            name: "WolfFoundation",
            type: .dynamic,
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
