//
//  KanbanPickerView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct KanbanPickerView: View {
    
    @Binding var currentStatus: Status
    var statuses: [Status]
    var tasksCount: [Status: Int]

    var body: some View {
        Picker("", selection: Binding<Status>(
            get: { currentStatus },
            set: { tag in
                withAnimation {
                    currentStatus = tag
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
        KanbanPickerView(
            currentStatus: .constant(.todo),
            statuses: Status.allCases,
            tasksCount: [.todo: 400, .inProgress: 155, .completed: 555]
        )
        .previewLayout(.sizeThatFits)
        .fixedSize()
    }
}
