//
//  File.swift
//  
//
//  Created by Alex Guretzki on 17/02/2023.
//

import Foundation

public struct Rules: Codable {
    let include: [any ParserRule]
    let exclude: [any ParserRule]
    
    static let availableRules: [any ParserRule.Type] = [
        FileExtensionRule.self,
        PathRule.self
    ]
    
    public init(include: [any ParserRule], exclude: [any ParserRule]) {
        self.include = include
        self.exclude = exclude
    }
    
    enum CodingKeys: String, CodingKey {
        case include = "include"
        case exclude = "exclude"
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let includeContainer = try container.nestedUnkeyedContainer(forKey: .include)
        let excludeContainer = try container.nestedUnkeyedContainer(forKey: .exclude)
        
        self.include = Self.rulesFromContainer(inputContainer: includeContainer)
        self.exclude = Self.rulesFromContainer(inputContainer: excludeContainer)
    }
    
    public func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var includeContainer = container.nestedUnkeyedContainer(forKey: .include)
        for rule in include {
            try includeContainer.encode(rule)
        }
        
        var excludeContainer = container.nestedUnkeyedContainer(forKey: .exclude)
        for rule in exclude {
            try excludeContainer.encode(rule)
        }
    }
}

private extension Rules {
    
    static func rulesFromContainer(inputContainer: UnkeyedDecodingContainer) -> [any ParserRule] {
        
        struct Empty: Codable {}
        
        var container = inputContainer
        var rules = [any ParserRule]()
        
        while !container.isAtEnd {
            
            for rule in availableRules {
                if let parserRule = try? container.decode(rule.self) {
                    rules.append(parserRule)
                    continue
                }
            }
            
            print("⚠️ UNHANDLED RULE ⚠️")
            // Skipping if not implemented
            _ = try? container.decode(Empty.self)
        }
        
        return rules
    }
}
