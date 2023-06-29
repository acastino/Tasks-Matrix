//
//  ListView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct ListView: View {

    var matrix: Matrix

    @State var allTasks = TaskItem.sampleData
    var tasksByMatrix: [TaskItem] {
        allTasks.filter(by: matrix)
    }

    @State var currentStatus: Status = .todo
    var tasksToShow: [TaskItem] {
        tasksByMatrix.filter(by: currentStatus)
    }

    @State var isEditing = false
    @State var sheetShown = false
    @State var modifyingItem: TaskItem = .emptyTask(with: .crises)

    var body: some View {
        List(tasksToShow) { task in
            VStack(alignment: .leading) {
                HStack {
                    Text(task.title)
                    Spacer()
                }
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                
//                Button("Move to In Progress") {
//                    guard let index = allTasks.firstIndex(where: { $0.id == task.id }) else {
//                        return
//                    }
//                    withAnimation {
//                        allTasks[index].status = .inProgress
//                    }
//                }
                
            }
            .background(.gray.opacity(0.001))
            .onTapGesture {
                openSheetToEdit(task)
            }
        }
        .navigationTitle(matrix.name)
        .toolbar {
            ToolbarItem(placement: .status) {
                KanbanPickerView(
                    currentStatus: $currentStatus,
                    tasksByMatrix: tasksByMatrix
                )
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    openSheetWithNewTaskItem()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $sheetShown) {
            AddEditTaskItemSheet(isEditing: $isEditing, taskItem: $modifyingItem) {
                sheetShown.toggle()
            } onSuccess: {
                saveChangesMadeToTaskItem()
            }
        }
    }

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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView(matrix: .crises)
        }
    }
}
