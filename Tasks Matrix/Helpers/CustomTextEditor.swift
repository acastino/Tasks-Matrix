//
//  CustomTextEditor.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

struct CustomTextEditor: View {
    
    let title: any StringProtocol
    @Binding var text: String
    
    init(_ title: any StringProtocol, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Text(text)
                .padding(.bottom, 20)
                .opacity(0)
            TextEditor(text: .constant(String(title)))
                .foregroundColor(text.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: text.isEmpty ? 0 : -27)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .topLeading)
                .padding(.horizontal, -5)
                .allowsHitTesting(false)
            TextEditor(text: $text)
                .padding(.horizontal, -5)
        }
        .padding(.top, text.isEmpty ? 0 : 17)
        .animation(.default, value: text)
    }
}
