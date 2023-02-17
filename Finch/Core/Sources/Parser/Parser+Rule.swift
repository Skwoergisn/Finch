//
//  File.swift
//  
//
//  Created by Dorian on 17/02/2023.
//

import Foundation

public protocol ParserRule: Codable, Identifiable {
    var id: String { get }
    func matches(filePath: String) -> Bool
}
