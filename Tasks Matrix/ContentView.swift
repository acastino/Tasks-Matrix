//
//  ContentView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                GroupBox(
                    label: Label("Urgent and Important", systemImage: "exclamationmark.triangle")
                ) {
                    Text("Do")
                        .foregroundColor(Color.gray)
                    Text("  123  ")
                        .background(.green)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: -9, leading: 0, bottom: -7, trailing: 0))
                    Text("Crises")
                }
                GroupBox(
                    label: Label("Not Urgent but Important", systemImage: "flag.checkered")
                ) {
                    Text("Plan")
                        .foregroundColor(Color.gray)
                    Text("  123  ")
                        .background(.blue)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: -9, leading: 0, bottom: -7, trailing: 0))
                    Text("Goals")
                }
            }
            HStack {
                GroupBox(
                    label: Label("Urgent but Not Important", systemImage: "person.2.badge.gearshape")
                ) {
                    Text("Delegate or\nAutomate")
                        .foregroundColor(Color.gray)
                    Text("  123  ")
                        .background(.orange)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: -9, leading: 0, bottom: -7, trailing: 0))
                    Text("Interruptions")
                }
                GroupBox(
                    label: Label("Not Urgent and Not Important", systemImage: "clock.arrow.circlepath")
                ) {
                    Text("Eliminate or\nPostpone")
                        .foregroundColor(Color.gray)
                    Text("  123  ")
                        .background(.gray)
                        .cornerRadius(10)
                        .padding(EdgeInsets(top: -9, leading: 0, bottom: -7, trailing: 0))
                    Text("Distractions")
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
