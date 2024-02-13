//
//  ChooseLocationVCLayout.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import UIKit

class ChooseLocationVCLayout: NSObject {
    
    fileprivate weak var viewController: ChooseLocationViewController!
    
//  - Init
    init(viewController: ChooseLocationViewController!) {
        self.viewController = viewController
        super.init()
        configure()
    }
}

// MARK: - Configure
extension ChooseLocationVCLayout {
    private func configure(){
        setSheetPresentationController()
        setUI()
    }
    
    private func setSheetPresentationController(){
        guard let vc = viewController else { return }
        vc.sheetPresentationController?.delegate = vc
        vc.sheetPresentationController?.prefersGrabberVisible = true
        vc.sheetPresentationController?.selectedDetentIdentifier = .medium
        vc.sheetPresentationController?.detents = [.medium(), .large()]
        vc.sheetPresentationController?.preferredCornerRadius = 32
    }
    
    private func setUI(){
        guard let vc = viewController else { return }
        let cancelAttrString = NSAttributedString(string: Localized.cancelBtn, attributes: [.font : UIFont.herpi(type: .semiBold, size: 15)])
        let acceptAttrString = NSAttributedString(string: Localized.acceptBtn, attributes: [.font : UIFont.herpi(type: .semiBold, size: 15)])
        vc.cancelBtn.setAttributedTitle(cancelAttrString, for: .normal)
        vc.acceptBtn.setAttributedTitle(acceptAttrString, for: .normal)
        vc.acceptBtn.layer.cornerRadius = vc.acceptBtn.frame.height / 2
        vc.headerTitle.text = Localized.header
        vc.descriptionTitle.text = Localized.description
        vc.currentLocationLbl.text = vc.currentLocation
    }
    
    private enum Localized {
        static let header = "რეგიონის არჩევა"
        static let description = "სასურველი ადგილის მოსანიშნად რუკაზე თითის ერთი შეხების დასვით პინი და შემდეგ დააჭირე 'მონიშვნა'-ს."
        static let cancelBtn = "გაუქმება"
        static let acceptBtn = "მონიშვნა"
    }
}
