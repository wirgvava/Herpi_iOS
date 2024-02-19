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
        vc.cancelBtn.setAttrString(string: Localized.cancelBtn.localized, fontSize: 15)
        vc.acceptBtn.setAttrString(string: Localized.acceptBtn.localized, fontSize: 15)
        vc.acceptBtn.layer.cornerRadius = vc.acceptBtn.frame.height / 2
        vc.headerTitle.text = Localized.header.localized
        vc.descriptionTitle.text = Localized.description.localized
        vc.currentLocationLbl.text = vc.currentLocation
    }
    
    private enum Localized {
        static let header = "currentLoc.header"
        static let description = "currentLoc.description"
        static let cancelBtn = "currentLoc.dismiss.button"
        static let acceptBtn = "currentLoc.pin.button"
    }
}
