//
//  AddTaskItemSheet.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct AddEditTaskItemSheet: View {
    
    @Binding var isEditing: Bool
    @Binding var taskItem: TaskItem
    let completion: () -> Void
    let onSuccess: () -> Void
    let onCancel: () -> Void = {}
    
    private var title: String {
        (isEditing ? "Edit " : "Add ") + taskItem.matrix.singularTerm
    }
    
    var body: some View {
        NavigationStack {
            AddEditForm(taskItem: $taskItem)
                .navigationTitle(
                    Text(title)
                )
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            completion()
                            onCancel()
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            completion()
                            onSuccess()
                        }
                    }
                }
        }
        .interactiveDismissDisabled(true)
    }
}

struct AddTaskItemSheet_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
        }.sheet(isPresented: .constant(true)) {
            AddEditTaskItemSheet(
                isEditing: .constant(true),
                taskItem: .constant(.emptyTask(with: .crises)),
                completion: {},
                onSuccess: {}
            )
        }
    }
}
