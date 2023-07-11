//
//  ListOfRowItems.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/5/23.
//

import SwiftUI

struct ListOfRowItems<Item: Identifiable, Content: View>: View {

    let items: [Item]

    @ViewBuilder let content: (Item) -> Content
    
    init(_ items: [Item], content: @escaping (Item) -> Content) {
        self.items = items
        self.content = content
    }

    var body: some View {
        List {
            ForEach(items) { item in
                content(item)
            }
            .padding(.vertical, -5)
            .padding(.horizontal, -20)
        }
    }
}
