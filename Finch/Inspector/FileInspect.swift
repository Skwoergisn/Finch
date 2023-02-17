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
        VStack(alignment: .center, spacing: 20) {
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 150)
            (Text("\(viewModel.appInfo.name) (v ")
             + Text(viewModel.appInfo.marketingVersion)
                .bold()
             + Text(")"))
            .font(.title)
            Text("\(viewModel.appInfo.filePaths.count) file(s)")
        }
    }
}

struct FileInspect_Previews: PreviewProvider {
    static var previews: some View {
        FileInspect(viewModel: .init(appInfo: .init(name: "My App", marketingVersion: "1.2.3", bundleVersion: "89238", filePaths: ["main.swift"])))
    }
}
