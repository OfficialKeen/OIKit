// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "OIKit",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "OIKit",
            targets: ["OIKit"]
        ),
    ],
    targets: [
        .target(
            name: "OIKit",
            path: "OIKit/OIKit"
        )
    ]
)