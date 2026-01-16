//
//  Color+Extension.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 14.01.26.
//

import SwiftUI

extension Color {
    /// Initialize a Color from a hex string
    /// - Parameter hex: Hex color string (supports formats: "#RRGGBB", "RRGGBB", "#RRGGBBAA", "RRGGBBAA")
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (no alpha)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // RGBA
            (r, g, b, a) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
