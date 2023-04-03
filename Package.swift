// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "HCSStarRatingView",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "HCSStarRatingView", targets: ["HCSStarRatingView"])
    ],
    targets: [
        .target(
            name: "HCSStarRatingView",
            path: "HCSStarRatingView",
            exclude: ["Info.plist"]
        )
    ]
)
