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
                CustomPicker("Matrix", selection: matrix, chosenItem: $taskItem.matrix) { matrix in
                    Text(matrix.name)
                }
                CustomPicker("Status", selection: statuses, chosenItem: $taskItem.status) { status in
                    Text(status.rawValue)
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
