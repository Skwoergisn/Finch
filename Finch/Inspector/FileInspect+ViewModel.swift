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
        
        let onParsingResult: (Parser.Result) -> Void
        
        init(appInfo: AppInfo, onParsing: @escaping (Parser.Result) -> Void) {
            self.appInfo = appInfo
            self.onParsingResult = onParsing
        }
        
        func handleAnalyseTapped() {
            let rules = Rules(
                include: [],
                exclude: [
                    FileExtensionRule.custom(extension: ".swift"),
                    FileExtensionRule.custom(extension: ".xcscheme")
                ]
            )
            let parser = Parser(rules: rules)
            let result = parser.parse(appInfo.filePaths)
            onParsingResult(result)
//            self.destination = .result(result: result)
        }
    }
}
