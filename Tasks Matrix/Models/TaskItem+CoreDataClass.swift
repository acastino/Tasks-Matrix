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
        self.matrix = copy.matrix
        self.notes = copy.notes
        self.status = copy.status
        self.title = copy.title
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

extension TaskItem {
    static var sampleData: [TaskItem] {
        [
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .crises),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisd", matrix: .crises),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisd", matrix: .crises),
            TaskItem(title: "Crises type", notes: "", matrix: .crises, status: .inProgress),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio ds", matrix: .crises, status: .inProgress),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio ds", matrix: .crises, status: .inProgress),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .crises, status: .completed),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .crises, status: .completed),
            TaskItem(title: "Crises type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .crises, status: .completed),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals, status: .inProgress),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals, status: .inProgress),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals, status: .completed),
            TaskItem(title: "Goals type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .goals, status: .completed),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions, status: .inProgress),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions, status: .inProgress),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions, status: .completed),
            TaskItem(title: "Interruptions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .interruptions, status: .completed),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions, status: .inProgress),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions, status: .inProgress),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions, status: .completed),
            TaskItem(title: "Distractions type", notes: "tehjlfaksf hads fhaisdh aisuhf aisuhfiadsh fioadhsfio dsahfioudhs ifhdsaifh oasfhs as adsfndfsgkljh jklj jk  hj  hjk hjkg hjkghjk ghjk hj hjk hjkg hj ghjkg", matrix: .distractions, status: .completed),
        ]
    }
}
