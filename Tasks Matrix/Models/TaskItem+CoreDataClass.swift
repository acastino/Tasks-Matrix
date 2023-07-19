//
//  TaskItem+CoreDataClass.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/10/23.
//
//

import Foundation
import CoreData

@objc(TaskItem)
public class TaskItem: NSManagedObject {
    let context = PersistenceController.shared.container.viewContext
    var matrixCallback: (Matrix) -> Void = {_ in }
}

extension TaskItem {
    var title: String {
        get {
            titleRawStringValue ?? ""
        }
        set {
            titleRawStringValue = newValue
        }
    }
    var notes: String {
        get {
            notesRawStringValue ?? ""
        }
        set {
            notesRawStringValue = newValue
        }
    }
    var matrix: Matrix {
        get {
            Matrix(rawValue: matrixRawEnumVal!)!
        }
        set {
            matrixRawEnumVal = newValue.rawValue
            matrixCallback(newValue)
        }
    }
    var status: Status {
        get {
            Status(rawValue: statusRawEnumVal!)!
        }
        set {
            statusRawEnumVal = newValue.rawValue
        }
    }

    convenience init(id: UUID = UUID(), title: String, notes: String, matrix: Matrix, status: Status = .todo) {
        self.init(entity: TaskItem.entity(), insertInto: nil)
        self.id = id
        self.title = title
        self.notes = notes
        self.matrix = matrix
        self.status = status
        self.dateCreatedVal = .now
        self.dateUpdatedVal = .now
    }

    static func emptyTask(with matrix: Matrix) -> TaskItem {
        TaskItem(title: "", notes: "", matrix: matrix)
    }

    func saveAsNewItem() {
        context.insert(self)
        try? context.save()
    }

    func update(with copy: TaskItem) {
        self.id = copy.id
        self.title = copy.title
        self.notes = copy.notes
        self.matrix = copy.matrix
        self.status = copy.status
        self.dateUpdatedVal = .now
        try? context.save()
    }
}

extension [TaskItem] {
    func filter(by status: Status) -> [TaskItem] {
        self.filter { $0.status == status }
    }

    func filter(by matrix: Matrix) -> [TaskItem] {
        self.filter { $0.matrix == matrix }
    }
}
