// swift-tools-version:5.6
 
import PackageDescription
 
let package = Package(
    name: "Swift-Math",
    platforms: [.iOS("15.2")],
    products: [
        .library(
            name: "Swift-Math",
            targets: ["Swift-Math"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Swift-Math",
            dependencies: []),
        .testTarget(
            name: "Swift-MathTests",
            dependencies: ["Swift-Math"]),
    ]
)
