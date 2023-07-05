//
//  SwipeToLeftContent.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/5/23.
//

import SwiftUI

struct SwipeToLeftContent: View {

    let task: TaskItem
    let triggerFullSwipeEvent: () -> Void
    
    init(_ task: TaskItem, _ triggerFullSwipeEvent: @escaping () -> Void) {
        self.task = task
        self.triggerFullSwipeEvent = triggerFullSwipeEvent
    }

    var body: some View {
        ZStack {
            VStack {
                LinearGradient(
                    gradient: .init(colors: [task.status.swipeToLeft_nextStep.swipeBgColor, .white]),
                    startPoint: .trailing,
                    endPoint: .leading
                )
            }
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    HStack {
                        Text("Move to:")
                        Text(task.status.swipeToLeft_nextStep.rawValue)
                            .fontWeight(.medium)
                    }
                    Image(systemName: task.status.swipeToLeft_icon)
                        .onTapGesture {
                            triggerFullSwipeEvent()
                        }
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SwipeToLeftContent_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToLeftContent(.emptyTask(with: .crises), {})
    }
}
