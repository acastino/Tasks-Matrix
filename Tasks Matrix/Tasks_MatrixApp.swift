//
//  Tasks_MatrixApp.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

@main
struct Tasks_MatrixApp: App {
    let context = PersistenceController.shared.container.viewContext
    var body: some Scene {
        WindowGroup {
            MatrixView()
                .environment(\.managedObjectContext, context)
        }
    }
}
