//
//  Colors.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 14.01.26.
//

import SwiftUI
import HerpiFoundation

public enum HerpiColor {
    
    public static let background: Color = .init(hex: "#F1F5F4")
    public static let white: Color = .init(hex: "#FFFFFF")
    public static let tint: Color = .init(hex: "#045446")
    public static let dark: Color = .init(hex: "#4B5556")
    public static let creme: Color = .init(hex: "#FFE3B3")
    public static let gray: Color = .init(hex: "#7F8B91")
    
    public enum Title {
        public static let primary: Color = .init(hex: "#494D50")
        public static let secondary: Color = .init(hex: "#67737C")
        public static let green: Color = .init(hex: "#017F71")
    }
    
    public enum VenomType {
        public static let midVenomous: Color = .init(hex: "#FFC000")
        public static let noVenomous: Color = .init(hex: "#00B988")
        public static let venomous: Color = .init(hex: "#FF0050")
    }
}
