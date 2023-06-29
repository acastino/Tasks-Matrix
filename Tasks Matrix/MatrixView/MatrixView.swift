//
//  MatrixView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct MatrixView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    let matrixCases = Matrix.allCases
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(matrixCases, id: \.self) { matrix in
                    NavigationLink {
                        ListView(matrix: matrix)
                    } label: {
                        GroupBoxView(matrix: matrix)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .navigationTitle("Tasks Matrix")
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixView()
    }
}
