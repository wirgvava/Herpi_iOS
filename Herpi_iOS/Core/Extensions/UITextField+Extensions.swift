//
//  UITextField+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 19.02.24.
//

import UIKit

extension UITextField {
    var string: String {
        return self.text ?? ""
    }
    
    @IBInspectable var localizedText : String { get { return self.string } set { self.text = newValue.localized } }
    
    @IBInspectable var localizedPlaceholder : String { get { return self.placeholder ?? "" } set { self.placeholder = newValue.localized } }
}
