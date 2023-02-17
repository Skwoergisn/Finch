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
///

public typealias RuleId = String

public struct Parser {

    public let rules: Rules
    
    public init(rules: Rules) {
        self.rules = rules
    }
    
    public func parse(_ paths: [String]) -> Result {
        
        var includes: [RuleId: [String]] = [:]
        var excludes: [RuleId: [String]] = [:]
        
        self.rules.include.forEach { includeRule in
            includes[includeRule.id] = paths.filter { !includeRule.matches(filePath:$0) }
        }
        
        self.rules.exclude.forEach { excludeRule in
            excludes[excludeRule.id] = paths.filter { excludeRule.matches(filePath:$0) }
        }
        
        return .init(includes: includes, excludes: excludes)
    }
}

public extension Parser {
    
    struct Result {
        /// Rules where a pass was expected, but the given paths failed
        public let includes: [RuleId: [String]]
        
        /// Rules where a pass was not expected, but the given paths succeeded
        public let excludes: [RuleId: [String]]
        
        public init(includes: [RuleId : [String]], excludes: [RuleId : [String]]) {
            self.includes = includes
            self.excludes = excludes
        }
    }
}
