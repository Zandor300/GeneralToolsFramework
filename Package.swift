// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "GeneralToolsFramework",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v7),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "GeneralToolsFramework", targets: ["GeneralToolsFramework"])
    ],
    dependencies: [
        .package(url: "https://github.com/pinterest/PINCache.git", from: "3.0.4"),
        .package(url: "https://git.zsinfo.nl/Zandor300/Connectivity.git", from: "8.0.2")
    ],
    targets: [
        .target(
            name: "GeneralToolsFramework",
            dependencies: [
                .product(name: "PINCache", package: "PINCache", condition: .when(platforms: [.iOS, .tvOS])),
                .product(name: "Connectivity", package: "Connectivity", condition: .when(platforms: [.iOS, .tvOS])),
                .target(name: "ZSPickerView", condition: .when(platforms: [.iOS]))
            ],
            path: "GeneralToolsFramework/Classes"
        ),
        // ZSPickerView 1.4 has no Swift package manifest; keep its module name and API.
        .target(
            name: "ZSPickerView",
            path: "Vendor/ZSPickerView",
            exclude: ["LICENSE", "README.md"]
        ),
        .testTarget(
            name: "GeneralToolsFrameworkTests",
            dependencies: ["GeneralToolsFramework"],
            path: "Example/Tests",
            exclude: ["Info.plist"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
