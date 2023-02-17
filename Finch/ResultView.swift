//
//  ResultView.swift
//  Finch
//
//  Created by Alex Guretzki on 17/02/2023.
//

import SwiftUI
import Parser

extension RuleId: Identifiable {
    public var id: String { return self }
}

struct ResultView: View {
    
    let result: Parser.Result
    
    var body: some View {
        List {
            Section("Excludes") {
                ForEach(result.excludes.keys.sorted()) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        if result.excludes[key]!.count == 0 {
                            Text("✅")
                        } else {
                            Text("\(result.excludes[key]!.count) Errors")
                        }
                    }
                }
            }
            Section("Includes") {
                ForEach(result.includes.keys.sorted()) { key in
                    HStack {
                        Text(key)
                        Spacer()
                        if result.excludes[key]!.count == 0 {
                            Text("✅")
                        } else {
                            Text("\(result.excludes[key]!.count) Errors")
                        }
                    }
                }
            }
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(
            result: .init(
                includes: ["Failing Rule" : ["random filepath"], "Succeeding Rule": []],
                excludes: ["Failing Rule" : ["random filepath"], "Succeeding Rule": []]
            )
        )
    }
}
