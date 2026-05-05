// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swiftui-codeeditorview-macos-demo",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/mchakravarty/CodeEditorView.git", from: "0.15.4"),
    ],
    targets: [
        .executableTarget(
            name: "swiftui-codeeditorview-macos-demo",
            dependencies: [
                .product(name: "CodeEditorView", package: "CodeEditorView"),
                .product(name: "LanguageSupport", package: "CodeEditorView"),
            ]
        ),
    ]
)
