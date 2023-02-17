//
//  RootView+ViewModel.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation
import Parser
import Inspector

extension RootView {
    class ViewModel: ObservableObject {
        
        @Published
        var app: AppInfo?
    }
}
