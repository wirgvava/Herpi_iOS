//
//  UIViewController+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 16.02.24.
//

import UIKit

extension UIViewController {
    func revealViewController() -> TopViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is TopViewController {
            return viewController! as? TopViewController
        }
        while (!(viewController is TopViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is TopViewController {
            return viewController as? TopViewController
        }
        return viewController as? TopViewController
    }
    
    @IBInspectable var localizedTitle : String { get { return self.title ?? "" } set { self.title = newValue.localized } }
}
