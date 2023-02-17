//
//  File.swift
//  
//
//  Created by Dorian on 17/02/2023.
//

import Foundation


public extension Parser {
    struct Rule: Identifiable, Hashable {
        public let id: String = UUID().uuidString
        public let name: String
        public let passes: (_ path: String) -> Bool
        
        public static func ==(lhs: Rule, rhs: Rule) -> Bool {
            lhs.id == rhs.id
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    }
}

extension Parser.Rule {
    /// Validates against any file that has the given mime type
    static func mimeType(_ mimeType: MimeType) -> Parser.Rule {
        .init(name: "MimeType") { path in
            path.hasSuffix(".\(mimeType.fileExtension)")
        }
    }
    
    /// Validates a file against the give path. Uses Wildcards (*\**, *?*)
    static func path(_ pathRule: String) -> Parser.Rule {
        .init(name: "Path") { path in
            
            func wildcard(_ string: String, pattern: String) -> Bool {
                let pred = NSPredicate(format: "self LIKE %@", pattern)
                return !NSArray(object: string).filtered(using: pred).isEmpty
            }
            
            return wildcard(path, pattern: pathRule) ? true : path == pathRule
        }
    }
}
