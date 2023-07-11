//
//  KanbanPickerView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct KanbanPickerView: View {

    var matrix: Matrix
    @Binding var currentStatus: Status
    
    @FetchRequest(entity: TaskItem.entity(), sortDescriptors: [])
    var allTasksQuery: FetchedResults<TaskItem>
    var allTasks: [TaskItem] {
        allTasksQuery.map { $0 }
    }
    var tasksByMatrix: [TaskItem] {
        allTasks.filter(by: matrix)
    }

    var statuses: [Status] = Status.visibleCases
    var tasksCount: [Status: Int] {
        Dictionary(uniqueKeysWithValues: statuses.map { status in
            (status, tasksByMatrix.filter(by: status).count)
        })
    }

    var body: some View {
        Picker("", selection: Binding<Status>(
            get: { currentStatus },
            set: { status in
                withAnimation {
                    currentStatus = status
                }
            }
        )) {
            ForEach(statuses, id: \.self) { status in
                Text("\(status.rawValue) (\(tasksCount[status]!))")
            }
        }
        .pickerStyle(.segmented)
    }
}

struct ScrumPickerView_Previews: PreviewProvider {
    static var previews: some View {
        let matrix: Matrix = .crises
        KanbanPickerView(
            matrix: matrix,
            currentStatus: .constant(.todo)
        )
        .previewLayout(.sizeThatFits)
        .fixedSize()
    }
}
