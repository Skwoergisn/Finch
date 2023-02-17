//
//  FileInspect.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation
import Inspector

extension FileInspect {
    class ViewModel: ObservableObject {
        
        let appInfo: AppInfo
        
        init(appInfo: AppInfo) {
            self.appInfo = appInfo
        }
    }
}
