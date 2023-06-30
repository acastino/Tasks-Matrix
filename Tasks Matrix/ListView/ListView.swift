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
        List {
            ForEach(tasksToShow) { task in
                VStack {
                    RowItemView(task: task) {
                        openSheetToEdit(task)
                    } onSwipe: {
                        moveTaskItemTo(task, status: .inProgress)
                    }
                }
            }
            .padding(.vertical, -5)
            .padding(.horizontal, -20)
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

//    func deleteTaskItem(_ task: TaskItem) {
//        guard let index = allTasks.firstIndex(where: { $0.id == task.id }) else {
//            return
//        }
//        allTasks.remove(at: index)
//    }

//    func showSwipeFromLeadingMenu(_ task: TaskItem) -> some View {
//        switch currentStatus {
//        case .todo:
//            return AnyView(
//                Button {
//                    withAnimation {
//                        moveTaskItemTo(task, status: .inProgress)
//                    }
//                } label: {
//                    Text("Move to:\n\(Status.inProgress.rawValue)")
//                }
//            )
//        case .inProgress:
//            return AnyView(
//                Button {
//                    withAnimation {
//                        moveTaskItemTo(task, status: .completed)
//                    }
//                } label: {
//                    Text("Move to:\n\(Status.completed.rawValue)")
//                }
//            )
//        case .completed:
//            return AnyView(
//                Button {
//                    deleteTaskItem(task)
//                } label: {
//                    Text("Delete")
//                }
//                    .tint(.red)
//            )
//        }
//    }
//
//    func showSwipeFromTrailingMenu(_ task: TaskItem) -> some View {
//        switch currentStatus {
//        case .inProgress:
//            return AnyView(
//                Button {
//                    withAnimation {
//                        moveTaskItemTo(task, status: .todo)
//                    }
//                } label: {
//                    Text("Move to:\n\(Status.todo.rawValue)")
//                }
//            )
//        case .completed:
//            return AnyView(
//                Button {
//                    withAnimation {
//                        moveTaskItemTo(task, status: .inProgress)
//                    }
//                } label: {
//                    Text("Move to:\n\(Status.inProgress.rawValue)")
//                }
//            )
//        default:
//            return AnyView(EmptyView())
//        }
//    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView(matrix: .crises)
        }
    }
}
