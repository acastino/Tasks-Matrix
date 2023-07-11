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
        modifyingItem = .emptyTask(with: matrix)
        modifyingItem.update(with: task)
        sheetShown.toggle()
    }

    func changeTaskStatusTo(_ task: TaskItem, status: Status) {
        isEditing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                modifyingItem = task
                modifyingItem.status = status
                saveChangesMadeToTaskItem()
            }
        }
    }

    func saveChangesMadeToTaskItem() {
        if isEditing {
            guard let index = allTasks.firstIndex(where: { $0.id == modifyingItem.id }) else {
                return
            }
            withAnimation {
                allTasks[index].update(with: modifyingItem)
            }
        } else {
            withAnimation {
                modifyingItem.saveAsNewItem()
            }
        }
    }
}
