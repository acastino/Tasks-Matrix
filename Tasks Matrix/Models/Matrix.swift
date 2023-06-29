//
//  Matrix.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/29/23.
//

import SwiftUI

enum Matrix: String, CaseIterable {
    case crises
    case goals
    case interruptions
    case distractions

    var label: String {
        switch self {
        case .crises: return "Urgent and Important"
        case .goals: return "Not Urgent but Important"
        case .interruptions: return "Urgent but Not Important"
        case .distractions: return "Not Urgent and Not Important"
        }
    }

    var systemImage: String {
        switch self {
        case .crises: return "exclamationmark.triangle"
        case .goals: return "flag.checkered"
        case .interruptions: return "person.2.badge.gearshape"
        case .distractions: return "clock.arrow.circlepath"
        }
    }

    var action: String {
        switch self {
        case .crises: return "Do"
        case .goals: return "Plan"
        case .interruptions: return "Delegate or Automate"
        case .distractions: return "Postpone or Eliminate"
        }
    }

    var name: String {
        self.rawValue.capitalized
    }

    var color: Color {
        switch self {
        case .crises: return .green
        case .goals: return .blue
        case .interruptions: return .orange
        case .distractions: return .gray
        }
    }
}
