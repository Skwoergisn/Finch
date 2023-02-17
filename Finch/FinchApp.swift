//
//  FinchApp.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI

@main
struct FinchApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(viewModel: .init())
        }
    }
}
