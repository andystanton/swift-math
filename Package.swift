// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "SwiftMath",
    platforms: [.iOS("16")],
    products: [
        .library(
            name: "SwiftMath",
            targets: ["SwiftMath"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftMath",
            dependencies: []),
        .testTarget(
            name: "SwiftMathTests",
            dependencies: ["SwiftMath"]),
    ]
)
