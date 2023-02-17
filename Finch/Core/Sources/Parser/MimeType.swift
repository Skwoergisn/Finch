//
//  File 2.swift
//  
//
//  Created by Dorian on 17/02/2023.
//

import Foundation

public struct MimeType {
    public let fileExtension: String
}

public extension MimeType {
    static let swift: MimeType = .init(fileExtension: "swift")
    static let xcScheme: MimeType = .init(fileExtension: "xcscheme")
}
