//
//  RowItemView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

struct RowItemView: View, SwipeSingleRowOnly {
    var task: TaskItem

    let onRowTapGesture: () -> Void
    let onSwipe: () -> Void

    @State private var cancelTap = false
    @State private var rowOffset: CGFloat = 0

    internal let ssro_id = UUID()
    internal var ssro_fetchSelf: RowItemView { self }
    internal func ssro_howToCancelSwipe() {
        cancelTap = false
        rowOffset = 0
    }

    var body: some View {
        ZStack {
            backgroundVStack()
            
            VStack {
                HStack {
                    gestureImage()
                        .onTapGesture {
                            withAnimation {
                                rowOffset = UIScene.screenWidth
                                handleSwipe()
                            }
                        }
                    imageCompanionHStack()
                    Spacer(minLength: 0)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 20)
            }
            
            VStack {
                Spacer()
                rowContentVStack()
                    .padding(.vertical, 5)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .background(.white)
            .contentShape(Rectangle())
            .offset(x: rowOffset)
            .gesture(
                DragGesture().onChanged(onSwipeChanged(_:)).onEnded(onSwipeEnded(_:))
            )
            .onTapGesture {
                ssro_cancelPreviousRowSwipe()
                if cancelTap {
                    return
                }
                onRowTapGesture()
            }
        }
    }
    
    func handleSwipe() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                rowOffset = 0
            }
        }
        cancelTap = false
        onSwipe()
    }
    
    func onSwipeChanged(_ value: DragGesture.Value) {
        ssro_cancelPreviousRowSwipe()
        let width = value.translation.width
        withAnimation {
            if width > 0 {
                rowOffset = width
            } else if width > -50 {
                rowOffset = 0
            }
        }
    }

    func onSwipeEnded(_ value: DragGesture.Value) {
        cancelTap = false
        let width = value.translation.width
        withAnimation {
            if width > 0 {
                if width > UIScene.screenWidth / 2 {
                    rowOffset = UIScene.screenWidth
                    handleSwipe()
                } else if rowOffset > 50 {
                    rowOffset = 50
                    cancelTap = true
                } else {
                    rowOffset = 0
                }
            } else {
                rowOffset = 0
            }
        }
    }
    
    
    
    
    func backgroundVStack() -> VStack<some View> {
        VStack {
            LinearGradient(
                gradient: .init(colors: [.blue, .white]),
                startPoint: .leading,
                endPoint: .trailing
            )
        }
    }
    
    func gestureImage() -> Image {
        Image(systemName: "envelope.arrow.triangle.branch")
    }
    
    func imageCompanionHStack() -> HStack<some View> {
        HStack {
            Text("Move to:")
            Text(Status.inProgress.rawValue)
                .fontWeight(.medium)
        }
    }
    
    func rowContentVStack() -> VStack<some View> {
        VStack(alignment: .leading) {
            HStack {
                Text(task.title)
                Spacer(minLength: 0)
            }
            if !task.notes.isEmpty {
                Text(task.notes)
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .lineLimit(2)
            }
        }
    }
    
}

struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        RowItemView(task: TaskItem.emptyTask(with: .crises), onRowTapGesture: {}, onSwipe: {})
    }
}
