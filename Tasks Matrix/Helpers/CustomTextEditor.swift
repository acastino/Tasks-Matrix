//
//  CustomTextEditor.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

struct CustomTextEditor: View {
    
    let title: any StringProtocol
    @Binding var text: String?
    @State private var textValue = ""
    
    init(_ title: any StringProtocol, text: Binding<String?>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(textValue)
                .padding(.bottom, 20)
                .opacity(0)
            Text(title)
                .foregroundColor(textValue.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(x: textValue.isEmpty ? 0 : -1, y: textValue.isEmpty ? 8 : -19)
                .scaleEffect(textValue.isEmpty ? 1 : 0.8, anchor: .leading)
            TextEditor(text: Binding<String>(
                get: { text ?? "" },
                set: { newValue in
                    withAnimation {
                        textValue = newValue
                        text = newValue
                    }
                }
            ))
                .padding(.horizontal, -5)
        }
        .padding(.top, textValue.isEmpty ? 0 : 17)
        .onAppear {
            textValue = text ?? ""
        }
    }
}
