//
//  Package.swift
//  OIKit
//
//  Created by keenoi on 11/04/25.
//

// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "OIKit", // Nama framework lo
    platforms: [
        .iOS(.v13), // Minimal iOS version yang didukung
    ],
    products: [
        .library(
            name: "OIKit", // Nama library yang dihasilkan
            targets: ["OIKit"] // Target yang dibuild
        ),
    ],
    targets: [
        .target(
            name: "OIKit", // Nama target yang akan dibuild
            path: "./OIKit" // Path menuju folder OIKit yang berisi semua file framework
        ),
    ]
)
