//
//  AddTaskItemSheet.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct AddEditTaskItemSheet: View {

    let matrix: Matrix
    @Binding var isEditing: Bool
    @Binding var taskItem: TaskItem
    let completion: () -> Void
    let onSuccess: () -> Void
    var onCancel: () -> Void = {}

    @State private var currentMatrix: Matrix
    private var title: String {
        taskItem.matrixCallback = { newValue in
            currentMatrix = newValue
        }
        return (isEditing ? "Edit " : "Add ") + currentMatrix.singularTerm
    }

    init(matrix: Matrix, isEditing: Binding<Bool>, taskItem: Binding<TaskItem>, completion: @escaping () -> Void, onSuccess: @escaping () -> Void, onCancel: @escaping () -> Void = {}) {
        self.matrix = matrix
        self._isEditing = isEditing
        self._taskItem = taskItem
        self.completion = completion
        self.onSuccess = onSuccess
        self.onCancel = onCancel
        self.currentMatrix = matrix
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
                matrix: .crises,
                isEditing: .constant(true),
                taskItem: .constant(.emptyTask(with: .crises)),
                completion: {},
                onSuccess: {}
            )
        }
    }
}
