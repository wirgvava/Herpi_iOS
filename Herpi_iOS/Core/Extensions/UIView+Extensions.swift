//
//  UIView+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import UIKit

extension UIView {
    class func instantiateFromNib <T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(viewType: self)
    }
}
