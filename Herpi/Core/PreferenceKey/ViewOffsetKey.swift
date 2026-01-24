//
//  ViewOffsetKey.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 24.01.26.
//

import SwiftUI

// MARK: - Preference Key for Scroll Tracking
struct ViewOffsetKey: PreferenceKey {
    static let defaultValue: [Int: CGFloat] = [:]
    
    static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
        value.merge(nextValue()) { $1 }
    }
}
