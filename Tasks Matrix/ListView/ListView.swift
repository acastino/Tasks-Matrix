//
//  ListView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct ListView: View {

    var matrix: Matrix

    @FetchRequest
    var allTasksQuery: FetchedResults<TaskItem>

    init(matrix: Matrix) {
        self.matrix = matrix
        self._allTasksQuery = FetchRequest(entity: TaskItem.entity(), sortDescriptors: [], predicate: NSPredicate(format: "matrixRawEnumVal = %@", matrix.rawValue))
    }

    var allTasks: [TaskItem] {
        allTasksQuery.map { $0 }
    }
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

    var hasSwipeToRight: Bool {
        true
    }
    var hasSwipeToLeft: Bool {
        currentStatus != .todo
    }

    var body: some View {
        ListOfRowItems(tasksToShow) { task in
            RowItemView(hasSwipeToRight: hasSwipeToRight, hasSwipeToLeft: hasSwipeToLeft) {
                VStack(alignment: .leading) {
                    HStack {
                        Text(task.title)
                        Spacer(minLength: 0)
                    }
                    if !task.notes.isEmpty {
                        Text(task.notes)
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .lineLimit(2)
                    }
                }
            } onTapGesture: {
                openSheetToEdit(task)
            } swipeToRight_content: { triggerFullSwipeEvent in
                SwipeToRightContent(task, triggerFullSwipeEvent)
            } swipeToRight_onSwipe: {
                changeTaskStatusTo(task, status: task.status.swipeToRight_nextStep)
            } swipeToLeft_content: { triggerFullSwipeEvent in
                SwipeToLeftContent(task, triggerFullSwipeEvent)
            } swipeToLeft_onSwipe: {
                changeTaskStatusTo(task, status: task.status.swipeToLeft_nextStep)
            }
        }
        .navigationTitle(matrix.name)
        .toolbar {
            ToolbarItem(placement: .status) {
                KanbanPickerView(
                    matrix: matrix,
                    currentStatus: $currentStatus
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
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView(matrix: .crises)
        }
    }
}
