//
//  Colors.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 06.02.24.
//

import UIKit

class Colors {
    
    // - UI
    static var selectedTint = UIColor(named: "selectedCategoryTint")
    static var defaultDark = UIColor(named: "defaultDark")
    static var white = UIColor.white
    static var headerTitle = UIColor(named: "HeaderTitle")
    static var greenTitle = UIColor(named: "GreenTitle")
    static var secondaryTitle = UIColor(named: "SecondaryTitle")
    
    // - Venomous type colors
    enum venomTypes {
        case venomous
        case midVenom
        case noVenom
    }
    
    static func venomType(_ type: venomTypes) -> UIColor {
        switch type {
        case .venomous:
            return UIColor(named: "venomous")!
        case .midVenom:
            return UIColor(named: "midVenomous")!
        case .noVenom:
            return UIColor(named: "noVenomous")!
        }
    }
}
