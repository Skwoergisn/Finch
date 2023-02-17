//
//  File.swift
//  
//
//  Created by Alex Guretzki on 17/02/2023.
//

import Foundation

public struct AppInfo: Hashable {
    public let name: String
    public let marketingVersion: String
    public let bundleVersion: String

    public let filePaths: [String]
    
    public init(name: String, marketingVersion: String, bundleVersion: String, filePaths: [String]) {
        self.name = name
        self.marketingVersion = marketingVersion
        self.bundleVersion = bundleVersion
        self.filePaths = filePaths
    }
}
