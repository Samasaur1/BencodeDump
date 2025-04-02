// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BencodeDump",
    platforms: [ .macOS(.v11) ],
    products: [ .executable(name: "bdump", targets: ["BencodeDump"])],
    dependencies: [
        .package(url: "https://github.com/onevcat/Rainbow", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Samasaur1/BencodingKit", branch: "fixes-for-bencodedump")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "BencodeDump",
            dependencies: [ "Rainbow", "BencodingKit" ]
        ),
    ]
)
