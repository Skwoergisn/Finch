//
//  FileInspect.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation
import Inspector
import Parser

extension FileInspect {
    class ViewModel: ObservableObject {
        
        enum Destination: Identifiable {
            var id: String {
                switch self {
                case .result: return "result"
                }
            }
            
            case result(result: Parser.Result)
        }
        
        let appInfo: AppInfo
        
        @Published var destination: Destination?
        
        init(appInfo: AppInfo) {
            self.appInfo = appInfo
        }
        
        func handleAnalyseTapped() {
            let rules = Rules(include: [], exclude: [FileExtensionRule.custom(extension: "plist")])
            let parser = Parser(rules: rules)
            let result = parser.parse(appInfo.filePaths)
            self.destination = .result(result: result)
        }
    }
}
