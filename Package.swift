// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "WalletConnectModal",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "WalletConnectModal",
            targets: ["WalletConnectModal"]),

    ],
    targets: [
        .target(
            name: "WalletConnectModal",
        ),
    ],
    swiftLanguageVersions: [.v5]
)
