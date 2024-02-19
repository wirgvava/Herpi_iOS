//
//  UILabel+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 19.02.24.
//

import UIKit

extension UILabel {
    var string : String { get { return self.text ?? "" } set { self.text = newValue } }

    
    @IBInspectable var localizedText : String { get { return self.string } set { self.text = newValue.localized } }
}
