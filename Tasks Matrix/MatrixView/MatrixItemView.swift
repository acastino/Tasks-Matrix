//
//  GroupBoxView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct MatrixItemView: View {
    let matrix: Matrix
    let count: Int
    var body: some View {
        ZStack {
            GroupBox(
                label: Label(matrix.label, systemImage: matrix.systemImage)
            ) {
                Text(matrix.action)
                    .foregroundColor(.gray)
                Text(String(count))
                    .padding(.horizontal, 10)
                    .background(matrix.color)
                    .cornerRadius(10)
                    .padding(EdgeInsets(top: -10, leading: 0, bottom: -6, trailing: 0))
                Text(matrix.name)
            }
            HStack {
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
                    .offset(x: -10)
            }
        }
        .padding(.bottom, 7)
    }
}

struct GroupBoxView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixItemView(matrix: .crises, count: 123)
            .previewLayout(.sizeThatFits)
            .fixedSize()
    }
}
