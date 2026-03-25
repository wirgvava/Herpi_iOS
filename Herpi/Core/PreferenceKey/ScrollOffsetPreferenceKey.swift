//
//  ScrollOffsetPreferenceKey.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 25.03.26.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    nonisolated(unsafe) static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
