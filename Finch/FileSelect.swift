//
//  FileSelect.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI

struct FileSelect: View {
    @StateObject
    var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Click to select .ipa (or drag & drop an ipa in this window)")
                .font(.title)
            Button {
                viewModel.selectFile()
            } label: {
                Image(systemName: "plus.square.dashed")
                    .resizable()
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(width: 100, height: 100)
                    .onDrop(of: ["public.url","public.file-url"], isTargeted: nil, perform: viewModel.handleDrop)
            }
        }
        .buttonStyle(.plain)
        .padding()
        
        if let url = viewModel.selectedFileURL {
            Text("Selected file: \(url.path())")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelect(viewModel: .init())
    }
}
