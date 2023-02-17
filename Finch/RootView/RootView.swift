//
//  RootView.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI
import Parser

struct RootView: View {
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        NavigationSplitView {
            if let app = viewModel.app {
                VStack {
                    FileInspect(viewModel: .init(appInfo: app))
                    Spacer()
                }
            } else {
                FileSelect(viewModel: .init(onAppSelected: { app in
                    viewModel.app = app
                }))
            }
        } detail: {
            if let app = viewModel.app {
                Text("App: \(app.name)")
            } else {
                FileSelect(viewModel: .init(onAppSelected: { app in
                    viewModel.app = app
                }))
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init())
    }
}
