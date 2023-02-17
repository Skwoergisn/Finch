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
    
    @State
    var result: Parser.Result?
    
    var body: some View {
        NavigationSplitView {
            if let app = viewModel.app {
                VStack {
                    FileInspect(viewModel: .init(appInfo: app, onParsing: { result in
                        self.result = result
                    }))
                    Spacer()
                }
            } else {
                FileSelect(viewModel: .init(onAppSelected: { app in
                    viewModel.app = app
                }))
            }
        } detail: {
            if let result {
                ResultView(result: result)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: .init())
    }
}
