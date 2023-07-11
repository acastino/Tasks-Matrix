//
//  CustomTextField.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

struct CustomTextField: View {

    let title: any StringProtocol
    @Binding var text: String?
    @State private var textValue = ""

    init(_ title: any StringProtocol, text: Binding<String?>) {
        self.title = title
        self._text = text
    }

    var body: some View {
        ZStack(alignment: .leading) {
            Text(title)
                .foregroundColor(textValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: textValue.isEmpty ? 0 : -28)
                .scaleEffect(textValue.isEmpty ? 1 : 0.8, anchor: .leading)
            TextField("", text: Binding<String>(
                get: { text ?? "" },
                set: { newValue in
                    textValue = newValue
                    text = newValue
                }
            ))
        }
        .padding(.top, textValue.isEmpty ? 0 : 17)
        .animation(.default, value: text)
        .onAppear {
            textValue = text ?? ""
        }
    }
}
