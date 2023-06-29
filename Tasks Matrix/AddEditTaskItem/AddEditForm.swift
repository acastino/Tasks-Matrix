//
//  AddEditSheet.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

struct AddEditForm: View {

    @Binding var taskItem: TaskItem

    var matrix = Matrix.allCases
    var statuses = Status.allCases
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        Form {
            Section {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(matrix, id: \.self) { item in
                        VStack {
                            HStack {
                                Spacer()
                                Text(item.name)
                                Spacer()
                            }
                            .frame(height: 55)
                            .background(taskItem.matrix==item ? .white : .gray.opacity(0.001))
                            .cornerRadius(8)
                            .onTapGesture {
                                withAnimation {
                                    taskItem.matrix = item
                                }
                            }
                        }
                        .padding(2.5)
                        .background(.gray.opacity(0.15))
                        .cornerRadius(10)
                    }
                }
                Picker("Status", selection: $taskItem.status) {
                    ForEach(statuses, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }.pickerStyle(.segmented)
            }
            Section {
                CustomTextField("Title", text: $taskItem.title)
                CustomTextEditor("Notes", text: $taskItem.notes)
            }
        }
    }
}

struct AddEditSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddEditForm(
            taskItem: .constant(.emptyTask(with: .crises))
        )
    }
}
