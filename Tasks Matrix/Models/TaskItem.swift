//
//  TaskItem.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import Foundation

struct TaskItem: Identifiable {
    let id = UUID()
    var title: String
    var notes: String
    var matrix: Matrix
    var status: Status = .todo
}

extension TaskItem {
    static func emptyTask(with matrix: Matrix) -> TaskItem {
        TaskItem(title: "", notes: "", matrix: matrix)
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
