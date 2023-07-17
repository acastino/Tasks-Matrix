//
//  CustomPicker.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/12/23.
//

import SwiftUI

struct CustomPicker<T: Hashable, Content: View>: View {

    let title: String
    let selection: [T]
    @Binding var chosenItem: T
    @ViewBuilder let content: (T) -> Content
    
    @State private var pickerBinding: T
    
    init(_ title: String, selection: [T], chosenItem: Binding<T>, content: @escaping (T) -> Content) {
        self.title = title
        self.selection = selection
        self._chosenItem = chosenItem
        self.content = content
        self._pickerBinding = State(initialValue: chosenItem.wrappedValue)
    }

    var body: some View {
        Picker(title, selection: Binding<T>(
            get: {
                pickerBinding
            }, set: { newValue in
                chosenItem = newValue
                pickerBinding = newValue
            }
        )) {
            ForEach(selection, id: \.self) { item in
                content(item)
            }
        }
    }
}
