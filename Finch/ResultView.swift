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

struct ResultViewItem: Identifiable {
    var id: String { UUID().uuidString }
    let name: String
    let count: Int?
    let children: [ResultViewItem]?
}

struct ResultView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let result: Parser.Result
    var includeItems = [ResultViewItem]()
    var excludeItems = [ResultViewItem]()
    
    init(result: Parser.Result) {
        self.result = result
        
        includeItems = result.includes.keys.map { ruleId in
            return .init(
                name: ruleId,
                count: result.includes[ruleId]!.count,
                children: result.includes[ruleId]!.map { .init(name: $0, count: nil, children: nil) }
            )
        }
        
        excludeItems = result.excludes.keys.map { ruleId in
            return .init(
                name: ruleId,
                count: result.excludes[ruleId]!.count,
                children: result.excludes[ruleId]!.map { .init(name: $0, count: nil, children: nil) }
            )
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Results")
                .padding()
            Divider()
            List(excludeItems, children: \.children) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    if let count = item.count {
                        Text("\(count)")
                    }
                }
            }
            
            Divider()
            
            HStack {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
            .padding()
        }
        .frame(width: 800, height: 500)
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
