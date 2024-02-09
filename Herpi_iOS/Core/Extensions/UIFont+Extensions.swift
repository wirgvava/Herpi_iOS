//
//  UIFont+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import UIKit

extension UIFont {
    enum MarkGEO: String {
        case regular = "MarkGEO-Regular"
        case semiBold = "MarkGEO-Semibold"
        case bold = "MarkGEO-Bold"
    }
    
    static func herpi(type: MarkGEO, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
