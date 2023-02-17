//
//  CreateRule.swift
//  Finch
//
//  Created by Dorian on 17/02/2023.
//

import SwiftUI

struct CreateRule: View {
    
    @State
    var selection: Selection = .path
    
    @State
    var ruleValue: String = ""
    
    let onCreate: ((Selection, String)) -> Void
    
    var body: some View {
        VStack {
            Picker(selection: $selection) {
                ForEach(Selection.allCases, id: \.hashValue) { selection in
                    Text(selection.displayName)
                }
            } label: {
                Text("Select Rule Type")
            }
            
            TextField("Value", text: $ruleValue)
            
            Button {
                onCreate((selection, ruleValue))
            } label: {
                Text("Create Rule")
            }

        }
        .padding()
    }
}

struct CreateRule_Previews: PreviewProvider {
    static var previews: some View {
        CreateRule(onCreate: { _ in })
    }
}

extension CreateRule {
    enum Selection: Hashable, CaseIterable {
        case path
        case mimetype
        
        var displayName: String {
            switch self {
            case .path: return "Path"
            case .mimetype: return "Extension"
            }
        }
    }
}
