//
//  UIButton+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 19.02.24.
//

import UIKit

extension UIButton {
    @IBInspectable var localizedTitle : String { get { return self.titleLabel?.text ?? "" } set { self.setTitle(newValue.localized, for: .normal) } }
    
 
    func setAttrString(string: String, fontSize: Int){
        let attrString = NSAttributedString(string: string, attributes: [.font : UIFont.herpi(type: .semiBold, size: fontSize.toCGFloat())])
        
        self.setAttributedTitle(attrString, for: .normal)
    }
}
