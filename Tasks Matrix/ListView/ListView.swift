//
//  ListView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct ListView: View {

    let matrix: Matrix
    
    var allTasks: [TaskItem] {
        TaskItem.sampleData.filter { $0.matrix == matrix }
    }
    
    @State var currentStatus: Status = .todo
    var statuses: [Status] = Status.allCases
    var tasksCount: [Status: Int] {
        Dictionary(uniqueKeysWithValues: statuses.map { status in
            (status, allTasks.filter { $0.status == status }.count)
        })
    }

    var tasksToShow: [TaskItem] {
        allTasks.filter { $0.status == currentStatus }
    }

    var body: some View {
        List(tasksToShow) { task in
            VStack(alignment: .leading) {
                Text(task.title)
                if !task.notes.isEmpty {
                    Text(task.notes)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
        }
        .navigationTitle(matrix.name)
        .toolbar {
            ToolbarItem(placement: .status) {
                KanbanPickerView(
                    currentStatus: $currentStatus,
                    statuses: statuses,
                    tasksCount: tasksCount
                )
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
