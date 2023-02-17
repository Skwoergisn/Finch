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
            Section(<#T##SwiftUI.LocalizedStringKey#>, content: <#T##() -> Content#>)
        }
    }
}

struct FileInspect_Previews: PreviewProvider {
    static var previews: some View {
        FileInspect(viewModel: .init(appName: "", files: <#T##[String]#>))
    }
}
