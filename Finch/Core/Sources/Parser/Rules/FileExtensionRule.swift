//
//  File 2.swift
//  
//
//  Created by Dorian on 17/02/2023.
//

import Foundation

public enum FileExtensionRule: ParserRule {
    
    public var id: String { return "file-extension-rule-\(fileExtension)"}
    
    public func matches(filePath: String) -> Bool {
        filePath.lowercased().hasSuffix(fileExtension.lowercased())
    }
    
    case swift
    case xcScheme
    case custom(extension: String)
    
    private var fileExtension: String {
        switch self {
        case .swift: return "swift"
        case .xcScheme: return "xcScheme"
        case .custom(let fileExtension): return fileExtension
        }
    }
}
