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
            checksum: "cedc3d5e3f77126a160e8d4fa26e2f17d6d3de06d478215e88c247c24f3e8754"
        ),
        .binaryTarget(
            name: "WCDBObjc",
            url: "https://github.com/Lakr233/wcdb-spm-prebuilt/releases/download/storage.2.1.15/WCDBObjc.xcframework.zip",
            checksum: "7b15d2979b320c59656b4d3f42ddd1a37f92aa0ac872f172ffebb57d615cead1"
        ),
    ]
)