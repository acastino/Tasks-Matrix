//
//  ListView+TaskItemChanges.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/1/23.
//

import SwiftUI

extension ListView {
    func openSheetWithNewTaskItem() {
        isEditing = false
        modifyingItem = .emptyTask(with: matrix)
        modifyingItem.status = currentStatus
        sheetShown.toggle()
    }

    func openSheetToEdit(_ task: TaskItem) {
        isEditing = true
        modifyingItem = task
        sheetShown.toggle()
    }

    func moveTaskItemTo(_ task: TaskItem, status: Status) {
        isEditing = true
        modifyingItem = task
        modifyingItem.status = status
        saveChangesMadeToTaskItem()
    }

    func saveChangesMadeToTaskItem() {
        if isEditing {
            guard let index = allTasks.firstIndex(where: { $0.id == modifyingItem.id }) else {
                return
            }
            withAnimation {
                allTasks[index] = modifyingItem
            }
        } else {
            withAnimation {
                allTasks.insert(modifyingItem, at: 0)
            }
        }
    }
}
