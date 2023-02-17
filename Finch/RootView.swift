//
//  RootView.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI
import Inspector

struct RootView: View {
    
    @State
    var apps: [AppInfo]
    
    @State
    var selectedApp: AppInfo?
    
    var body: some View {
        NavigationSplitView {
            List(apps, id: \.name, selection: $selectedApp) { app in
                Text(app.name)
            }
        } detail: {
            if let selectedApp {
                FileInspect(viewModel: .init(appInfo: selectedApp))
            } else {
                FileSelect(viewModel: .init())
            }
        }

    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(apps: [
            .init(name: "App1", marketingVersion: "", bundleVersion: "", filePaths: []),
            .init(name: "App2", marketingVersion: "", bundleVersion: "", filePaths: []),
            .init(name: "App3", marketingVersion: "", bundleVersion: "", filePaths: []),
            .init(name: "App4", marketingVersion: "", bundleVersion: "", filePaths: []),
            
        ])
    }
}
