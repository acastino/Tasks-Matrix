//
//  Status.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import Foundation
import SwiftUI

enum Status: String, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case completed = "Completed"
    case deleted = "Deleted"

    static var visibleCases: [Self] {
        Self.allCases.filter { status in
            status != .deleted
        }
    }
    var swipeBgColor: Color {
        switch self {
        case .todo: return .gray
        case .inProgress: return .blue
        case .completed: return .green
        case .deleted: return .red
        }
    }
    var swipeToRight_nextStep: Self {
        switch self {
        case .todo: return .inProgress
        case .inProgress: return .completed
        case .completed: return .deleted
        case .deleted: return self
        }
    }
    var swipeToRight_icon: String {
        switch self {
        case .completed: return "trash"
        default: return "envelope.arrow.triangle.branch"
        }
    }
    var swipeToLeft_nextStep: Self {
        switch self {
        case .todo: return self
        case .inProgress: return .todo
        case .completed: return .inProgress
        case .deleted: return .completed
        }
    }
    var swipeToLeft_icon: String {
        return "envelope.arrow.triangle.branch"
    }
}
