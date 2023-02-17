//
//  FileSelect+ViewModel.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import Foundation
import SwiftUI

extension FileSelect {
    class ViewModel: ObservableObject {
        @Published
        var selectedFileURL: URL?
        
        func handleDrop(_ items: [NSItemProvider]) -> Bool {
            if let item = items.first {
                if let identifier = item.registeredTypeIdentifiers.first {
                    print("onDrop with identifier = \(identifier)")
                    if identifier == "public.url" || identifier == "public.file-url" {
                        item.loadItem(forTypeIdentifier: identifier, options: nil) { (urlData, error) in
                            DispatchQueue.main.async {
                                if let urlData = urlData as? Data {
                                    let url = NSURL(absoluteURLWithDataRepresentation: urlData, relativeTo: nil) as URL
                                    
                                    self.selectedFileURL = url
                                }
                            }
                        }
                    }
                }
                return true
            } else {
                print("item not here")
                return false
            }
        }
        
        func selectFile() {
            NSOpenPanel.openApp { (result) in
                if case let .success(url) = result {
                    self.selectedFileURL = url
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
            if result == .OK,
               let url = panel.urls.first {
                completion(.success(url))
            } else {
                completion(.failure(
                    NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get file location"])
                ))
            }
        }
    }
}
