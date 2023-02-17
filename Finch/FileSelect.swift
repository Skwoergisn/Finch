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
            if viewModel.isLoading {
                ProgressView()
            } else if let url = viewModel.selectedApp {
                Text("Selected file: \(url.name)")
            } else {
                Text("Click to select .ipa")
                    .font(.title)
                    .padding(.bottom, 32)
                
                Button {
                    viewModel.selectFile()
                } label: {
                    Image(systemName: "plus.square.dashed")
                        .resizable()
                        .foregroundColor(.secondary.opacity(0.2))
                        .frame(width: 150, height: 150)
                }
                
                Text("or drag & drop an ipa in this window")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 32)
            }
        }
        .buttonStyle(.plain)
        .padding()
        .onDrop(of: ["public.url","public.file-url"], isTargeted: nil) {
            viewModel.handleDrop($0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FileSelect(viewModel: .init(onAppSelected: { _ in }))
    }
}
