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

    @State private var isEditing = false
    @State private var sheetShown = false
    @State private var modifyingItem: TaskItem = .emptyTask(with: .crises)

    var body: some View {
        List {
            ForEach(tasksToShow) { task in
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
                }
                .background(.gray.opacity(0.001))
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    showSwipeFromLeadingMenu(task)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    showSwipeFromTrailingMenu(task)
                }
                .onTapGesture {
                    openSheetToEdit(task)
                }
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
    
    func deleteTaskItem(_ task: TaskItem) {
        guard let index = allTasks.firstIndex(where: { $0.id == task.id }) else {
            return
        }
        _ = withAnimation {
            allTasks.remove(at: index)
        }
    }

    func showSwipeFromLeadingMenu(_ task: TaskItem) -> some View {
        switch currentStatus {
        case .todo:
            return AnyView(
                Button {
                    moveTaskItemTo(task, status: .inProgress)
                } label: {
                    Text("Move to:\n\(Status.inProgress.rawValue)")
                }
            )
        case .inProgress:
            return AnyView(
                Button {
                    moveTaskItemTo(task, status: .completed)
                } label: {
                    Text("Move to:\n\(Status.completed.rawValue)")
                }
            )
        case .completed:
            return AnyView(
                Button {
                    deleteTaskItem(task)
                } label: {
                    Text("Delete")
                }
                    .tint(.red)
            )
        }
    }

    func showSwipeFromTrailingMenu(_ task: TaskItem) -> some View {
        switch currentStatus {
        case .inProgress:
            return AnyView(
                Button {
                    moveTaskItemTo(task, status: .todo)
                } label: {
                    Text("Move to:\n\(Status.todo.rawValue)")
                }
            )
        case .completed:
            return AnyView(
                Button {
                    moveTaskItemTo(task, status: .inProgress)
                } label: {
                    Text("Move to:\n\(Status.inProgress.rawValue)")
                }
            )
        default:
            return AnyView(EmptyView())
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
