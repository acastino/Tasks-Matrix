//
//  RowItemView.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

struct RowItemView<Content: View, SRContent: View, SLContent: View>: View, SwipeSingleRowOnly {
    
    let hasSwipeToRight: Bool
    let hasSwipeToLeft: Bool

    @ViewBuilder let content: () -> Content
    let onTapGesture: () -> Void

    @ViewBuilder let swipeToRight_content: (_ triggerFullSwipeEvent: @escaping () -> Void) -> SRContent
    let swipeToRight_onSwipe: () -> Void

    @ViewBuilder let swipeToLeft_content: (_ triggerFullSwipeEvent: @escaping () -> Void) -> SLContent
    let swipeToLeft_onSwipe: () -> Void

    @State private var cancelTap = false
    @State private var rowOffset: CGFloat = 0
    let partialSwipeHoldAtWidth: CGFloat = 48
    var isSwipingToRight: Bool? {
        rowOffset > 0 ? true : rowOffset < 0 ? false : nil
    }
    var triggerUserDefined_onSwipe: () -> Void {
        guard let isSwipingToRight else {
            return {}
        }
        return isSwipingToRight ? swipeToRight_onSwipe : swipeToLeft_onSwipe
    }

    let ssro_id = UUID()
    var ssro_fetchSelf: RowItemView { self }
    func ssro_howToCancelSwipe() {
        cancelTap = false
        rowOffset = 0
    }

    var body: some View {
        ZStack {
            if let isSwipingToRight, !isSwipingToRight && hasSwipeToLeft {
                VStack {
                    swipeToLeft_content(triggerFullSwipeEvent)
                }
            }
            
            ZStack {
                if let isSwipingToRight, isSwipingToRight && hasSwipeToRight {
                    VStack {
                        swipeToRight_content(triggerFullSwipeEvent)
                    }
                }
                
                VStack {
                    Spacer(minLength: 0)
                    HStack {
                        content()
                            .padding(.vertical, 5)
                            .padding(.horizontal, 20)
                        Spacer(minLength: 0)
                    }
                    Spacer(minLength: 0)
                }
                .background(.white)
                .offset(x: rowOffset > 0 ? rowOffset : 0)
                .gesture(
                    DragGesture().onChanged(onSwipeChanged(_:)).onEnded(onSwipeEnded(_:))
                )
                .onTapGesture {
                    ssro_cancelPreviousRowSwipe()
                    if cancelTap {
                        return
                    }
                    onTapGesture()
                }
            }
            .offset(x: rowOffset < 0 ? rowOffset : 0)
        }
    }
    
    func triggerFullSwipeEvent() {
        guard let isSwipingToRight else {
            return
        }
        cancelTap = true
        withAnimation {
            rowOffset = isSwipingToRight ? UIScene.screenWidth : -UIScene.screenWidth
            handleFullSwipeEvent()
        }
    }
    
    func handleFullSwipeEvent() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            cancelTap = false
            withAnimation {
                rowOffset = 0
            }
        }
        triggerUserDefined_onSwipe()
    }
    
    func onSwipeChanged(_ value: DragGesture.Value) {
        if !hasSwipeToLeft && !hasSwipeToRight {
            return
        }
        ssro_cancelPreviousRowSwipe()
        let width = value.translation.width
        withAnimation {
            if hasSwipeToLeft && hasSwipeToRight {
                rowOffset = width
            } else {
                if hasSwipeToRight && !hasSwipeToLeft {
                    if width > 0 {
                        rowOffset = width
                    } else {
                        rowOffset = 0
                    }
                } else if hasSwipeToLeft && !hasSwipeToRight {
                    if width < 0 {
                        rowOffset = width
                    } else {
                        rowOffset = 0
                    }
                } else {
                    rowOffset = 0
                }
            }
        }
    }

    func onSwipeEnded(_ value: DragGesture.Value) {
        guard let isSwipingToRight else {
            return
        }
        if !hasSwipeToLeft && !hasSwipeToRight {
            return
        }
        cancelTap = false
        let width = value.translation.width
        let widthAbsolute = isSwipingToRight ? width : -width
        let holdAtWidth = isSwipingToRight ? partialSwipeHoldAtWidth : -partialSwipeHoldAtWidth
        let handleSwipeEnd = {
            if widthAbsolute > UIScene.screenWidth / 2 {
                triggerFullSwipeEvent()
            } else if widthAbsolute > partialSwipeHoldAtWidth {
                rowOffset = holdAtWidth
                cancelTap = true
            } else {
                rowOffset = 0
            }
        }
        withAnimation {
            if hasSwipeToLeft && hasSwipeToRight {
                handleSwipeEnd()
            } else {
                if widthAbsolute > 0 {
                    handleSwipeEnd()
                } else {
                    rowOffset = 0
                }
            }
        }
    }
    
}

struct RowItemView_Previews: PreviewProvider {
    static var previews: some View {
        RowItemView(hasSwipeToRight: true, hasSwipeToLeft: true) {
            HStack {
                Text("content here")
                Spacer()
            }
        } onTapGesture: {
            
        } swipeToRight_content: { triggerFullSwipeEvent in
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Image(systemName: "plus")
                            .onTapGesture {
                                triggerFullSwipeEvent()
                            }
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .background(.blue)
        } swipeToRight_onSwipe: {
            
        } swipeToLeft_content: { triggerFullSwipeEvent in
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .onTapGesture {
                                triggerFullSwipeEvent()
                            }
                    }
                    .padding(.horizontal, 20)
                }
                Spacer()
            }
            .background(.green)
        } swipeToLeft_onSwipe: {
            
        }
    }
}
