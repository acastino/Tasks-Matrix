//
//  SwipeToRightContent.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 7/5/23.
//

import SwiftUI

struct SwipeToRightContent: View {
    
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
                    gradient: .init(colors: [task.status.swipeToRight_nextStep.swipeBgColor, .white]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            }
            VStack {
                HStack {
                    Image(systemName: task.status.swipeToRight_icon)
                        .onTapGesture {
                            triggerFullSwipeEvent()
                        }
                    HStack {
                        if task.status == .completed {
                            Text("Delete")
                        } else {
                            Text("Move to:")
                            Text(task.status.swipeToRight_nextStep.rawValue)
                                .fontWeight(.medium)
                        }
                    }
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
            }
        }
    }
}

struct SwipeToRightContent_Previews: PreviewProvider {
    static var previews: some View {
        SwipeToRightContent(.emptyTask(with: .crises), {})
    }
}
