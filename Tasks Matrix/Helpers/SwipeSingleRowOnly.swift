//
//  SwipeMonitor.swift
//  Tasks Matrix
//
//  Created by Amante Castino on 6/30/23.
//

import SwiftUI

protocol SwipeSingleRowOnly {
    var ssro_id: UUID { get }
    var ssro_fetchSelf: Self { get }
    func ssro_cancelPartialSwipe() -> Void
}
extension SwipeSingleRowOnly {
    func ssro_cancelPreviousRowSwipe() {
        SSRO_Monitor.shared.cancelPreviousRowSwipe(currentRow: ssro_fetchSelf)
    }
}

fileprivate class SSRO_Monitor {
    private init() {}
    static let shared = SSRO_Monitor()
    private var previousRow: SwipeSingleRowOnly?
    func cancelPreviousRowSwipe(currentRow: SwipeSingleRowOnly) {
        defer {
            previousRow = currentRow
        }
        guard let previousRow, previousRow.ssro_id != currentRow.ssro_id else {
            return
        }
        previousRow.ssro_cancelPartialSwipe()
    }
}
