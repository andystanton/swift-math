// swift-tools-version:5.6
 
import PackageDescription
 
let package = Package(
    name: "Swift-Math",
    products: [
        .library(
            name: "Swift-Math",
            targets: ["Swift-Math"]),
    ],
    targets: [
        .target(
            name: "Swift-Math",
            dependencies: []),
        .testTarget(
            name: "Swift-MathTests",
            dependencies: ["Swift-Math"]),
    ]
)
