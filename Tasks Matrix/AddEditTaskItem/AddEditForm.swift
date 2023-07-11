//
//  AddEditSheet.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct AddEditForm: View {

    @Binding var taskItem: TaskItem

    var matrix = Matrix.allCases
    var statuses = Status.visibleCases

    var body: some View {
        Form {
            Section {
                Picker("Matrix", selection: $taskItem.matrix) {
                    ForEach(matrix, id: \.self) { item in
                        Text(item.name)
                    }
                }
                Picker("Status", selection: $taskItem.status) {
                    ForEach(statuses, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
            }
            Section {
                CustomTextField("Title", text: $taskItem.titleRawStringValue)
                CustomTextEditor("Notes", text: $taskItem.notesRawStringValue)
            }
        }
    }
}

struct AddEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddEditForm(
            taskItem: .constant(.emptyTask(with: .crises))
        )
    }
}
