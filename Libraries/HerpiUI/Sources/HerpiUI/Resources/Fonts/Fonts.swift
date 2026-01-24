//
//  Fonts.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import SwiftUI

@MainActor
public enum HerpiFont {
    
    enum FontType: String {
        case regular = "MarkGEO-Regular"
        case semibold = "MarkGEO-Semibold"
        case bold = "MarkGEO-Bold"
    }
    
    private static func font(forType type: FontType, size: CGFloat) -> Font {
        Font.custom(type.rawValue, size: size)
    }
    
    // MARK: - List of Fonts
    
    /// `Regular` fonts
    public static let regular_14 = HerpiFont.font(forType: .regular, size: 14)
    public static let regular_18 = HerpiFont.font(forType: .regular, size: 18)
    
    /// `Semibold` fonts
    public static let semibold_10 = HerpiFont.font(forType: .semibold, size: 10)
    public static let semibold_13 = HerpiFont.font(forType: .semibold, size: 13)
    public static let semibold_14 = HerpiFont.font(forType: .semibold, size: 14)
    public static let semibold_15 = HerpiFont.font(forType: .semibold, size: 15)
    public static let semibold_16 = HerpiFont.font(forType: .semibold, size: 16)
    
    /// `Bold` fonts
    public static let bold_14 = HerpiFont.font(forType: .bold, size: 14)
}
