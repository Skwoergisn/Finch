//
//  FileInspect.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation

extension FileInspect {
    class ViewModel: ObservableObject {
        let appName: String
        
        let files: [String]
        
        init(appName: String, files: [String]) {
            self.appName = appName
            self.files = files
        }
    }
}
