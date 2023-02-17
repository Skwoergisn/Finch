//
//  File.swift
//  
//
//  Created by Alex Guretzki on 17/02/2023.
//

import Foundation

public struct PathRule: ParserRule {
    
    public var id: String { return "path-rule-\(pattern)"}
    
    public let pattern: String
    
    public init(pattern: String) {
        self.pattern = pattern
    }
    
    public func matches(filePath: String) -> Bool {
        
        func wildcard(_ string: String, pattern: String) -> Bool {
            let pred = NSPredicate(format: "self LIKE %@", pattern)
            return !NSArray(object: string).filtered(using: pred).isEmpty
        }
        
        return wildcard(filePath, pattern: pattern) ? true : filePath == pattern
    }
}
