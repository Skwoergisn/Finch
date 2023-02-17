//
//  Parser.swift
//  
//
//  Created by Dorian on 17/02/2023.
//

import Foundation

// Parse FileType
// Diff
//  - Location
//  -
/// Rules
/// - Includes: Filename, Filetype
/// - Excludes: Filename, Filetype

public struct Parser {
    /// Ensures all the given rules pass
    public var includes: [Rule]
    
    /// Ensures all the given rules do not pass
    public var excludes: [Rule]
    
    public func parse(_ paths: [String]) -> Result {
        var includes: [Rule: [String]] = [:]
        var excludes: [Rule: [String]] = [:]
        var success: Bool = true
        
        self.includes.forEach { includeRule in
            let offendingPaths = paths.filter { !includeRule.passes($0) }
            includes[includeRule] = offendingPaths
            success = success && offendingPaths.isEmpty
        }
        
        self.excludes.forEach { excludeRule in
            let offendingPaths = paths.filter(excludeRule.passes)
            excludes[excludeRule] = offendingPaths
            success = success && offendingPaths.isEmpty
        }
        
        return .init(success: success, includes: includes, excludes: excludes)
    }
}

public extension Parser {
    struct Result {
        let success: Bool
        
        /// Rules where a pass was expected, but the given paths failed
        let includes: [Rule: [String]]
        
        /// Rules where a pass was not expected, but the given paths succeeded
        let excludes: [Rule: [String]]
    }
}
