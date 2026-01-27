// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "wcdb-spm-prebuilt",
    platforms: [
        .iOS(.v12),
        .watchOS(.v5),
        .tvOS(.v12),
        .macOS(.v10_13),
        .macCatalyst(.v13),
    ],
    products: [
        .library(name: "WCDBSwift", targets: ["WCDBSwift"]),
        .library(name: "WCDBObjc", targets: ["WCDBObjc"]),
    ],
    targets: [
        .binaryTarget(
            name: "WCDBSwift",
            url: "https://github.com/Lakr233/wcdb-spm-prebuilt/releases/download/storage.2.1.15/WCDBSwift.xcframework.zip",
            checksum: "623049a3d8fb7643c5396de4f3b8d2ea0167dcb81573448dbece88f7bec4f3c0"
        ),
        .binaryTarget(
            name: "WCDBObjc",
            url: "https://github.com/Lakr233/wcdb-spm-prebuilt/releases/download/storage.2.1.15/WCDBObjc.xcframework.zip",
            checksum: "db539e30ccf36ed0b26353944897f3c1855c1d36c1c58032055c40c87c46f4f0"
        ),
    ]
)