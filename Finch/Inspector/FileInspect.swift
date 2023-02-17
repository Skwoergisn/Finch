//
//  FileInspect.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI

struct FileInspect: View {
    
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        List {
            VStack(alignment: .center, spacing: 20) {
                RoundedRectangle(cornerRadius: 36, style: .continuous)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 150)
                (Text("\(viewModel.appInfo.name) (v ")
                 + Text(viewModel.appInfo.marketingVersion)
                    .bold()
                 + Text(")"))
                .font(.title)
                
            }
            .frame(maxWidth: .infinity)
            Section("Files") {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.appInfo.filePaths, id: \.self) { path in
                            Text(path)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .border(Color.blue)
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                .background(
                    RoundedRectangle(cornerRadius: 36)
                        .fill(Color.gray.opacity(0.3))
                )
            }
        }
    }
    
    private var structure: [AppStructure] {
        [
            .init(name: "Files",
                  sections: viewModel.appInfo.filePaths.map({
                      .init(name: $0)
                  }))
        ]
    }
}

extension FileInspect {
    struct AppStructure: Identifiable {
        let id = UUID()
        let name: String
        let sections: [AppStructure]?
        
        init(name: String, sections: [AppStructure]? = nil) {
            self.name = name
            self.sections = sections
        }
    }
}

struct FileInspect_Previews: PreviewProvider {
    static var previews: some View {
        FileInspect(viewModel: .init(appInfo: .init(name: "My App", marketingVersion: "1.2.3", bundleVersion: "89238", filePaths: ["main.swift"])))
    }
}