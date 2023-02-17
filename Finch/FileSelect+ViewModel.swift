//
//  FileSelect+ViewModel.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation
import SwiftUI
import Inspector

extension FileSelect {
    
    @MainActor
    class ViewModel: ObservableObject {
        
        @Published
        var selectedApp: AppInfo?
        
        @Published
        var isLoading: Bool = false
        
        let onAppSelected: (AppInfo?) -> Void
        
        init(onAppSelected: @escaping (AppInfo?) -> Void) {
            self.selectedApp = nil
            self.isLoading = false
            self.onAppSelected = onAppSelected
        }
        
        func handleDrop(_ items: [NSItemProvider]) -> Bool {
            guard let item = items.first else { return false }
            guard let identifier = item.registeredTypeIdentifiers.first else { return false }
            
            print("onDrop with identifier = \(identifier)")
            guard identifier == "public.url" || identifier == "public.file-url" else { return false }
            
            item.loadItem(forTypeIdentifier: identifier, options: nil) { (urlData, error) in
                DispatchQueue.main.async { [weak self] in
                    self?.isLoading = true
                    if let urlData = urlData as? Data {
                        let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                        
                        Task {
                            try await Task.sleep(for: .seconds(3))
                            self?.selectedApp = try await Inspector.inspect(appAtUrl: url)
                            self?.isLoading = false
                            self?.onAppSelected(self?.selectedApp)
                        }
                    }
                }
            }
            
            return true
        }
        
        func selectFile() {
            NSOpenPanel.openApp { [weak self] (result) in
                if case let .success(url) = result {
                    self?.isLoading = true
                    Task {
                        self?.selectedApp = try await Inspector.inspect(appAtUrl: url)
                        self?.isLoading = false
                        self?.onAppSelected(self?.selectedApp)
                    }
                }
            }
        }
    }
}

extension NSOpenPanel {
    
    static func openApp(completion: @escaping (_ result: Result<URL, Error>) -> ()) {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseFiles = true
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.init(importedAs: "ipa")]
        panel.canChooseFiles = true
        panel.begin { (result) in
            if let url = panel.urls.first {
                completion(.success(url))
            } else {
                completion(.failure(
                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])
                ))
            }
        }
    }
}
