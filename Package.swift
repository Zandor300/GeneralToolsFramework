// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeneralToolsFramework",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "GeneralToolsFramework",
            targets: ["GeneralToolsFramework"]
        ),
    ],
    dependencies: [
         .package(url: "https://github.com/rwbutler/Connectivity.git", from: "5.3.0"),
         .package(url: "https://github.com/pinterest/PINCache.git", from: "3.0.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GeneralToolsFramework",
            dependencies: [
                "Connectivity",
                "PINCache",
            ],
            path: "Sources/GeneralToolsFramework"
        ),
        .testTarget(
            name: "GeneralToolsFrameworkTests",
            dependencies: ["GeneralToolsFramework"]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
