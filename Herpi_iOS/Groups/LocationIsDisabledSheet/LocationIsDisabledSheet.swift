//
//  LocationIsDisabledSheet.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 17.02.24.
//

import UIKit

class LocationIsDisabledSheet: UIViewController, UISheetPresentationControllerDelegate {
    
//  MARK: - IBOutlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }

//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSheetPresentationController()
        setUI()
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
 
//  MARK: - IBActions
    @IBAction func didTapOkBtn(){
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    private func setSheetPresentationController(){
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.selectedDetentIdentifier = .medium
        sheetPresentationController?.detents = [.medium()]
        sheetPresentationController?.preferredCornerRadius = 32
    }
    
    private func setUI(){
        header.text = Localized.header.localized
        descr.text = Localized.description.localized
        okBtn.setAttrString(string: Localized.okBtn.localized, fontSize: 15)
        settingsBtn.setAttrString(string: Localized.settingsBtn.localized, fontSize: 15)
        okBtn.layer.cornerRadius = okBtn.frame.height / 2
        settingsBtn.layer.cornerRadius = settingsBtn.frame.height / 2
    }
    
    private enum Localized {
        static let header = "disabled.location.header"
        static let description = "disabled.location.description"
        static let okBtn = "disabled.location.ok.button"
        static let settingsBtn = "disabled.location.settins.button"
    }
}

// MARK: - Notifications
extension LocationIsDisabledSheet {
    func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }
    
    func subscribe(){
        let center = NotificationCenter.default
        let languageSwitched = Notifications.languageSwitched.notificationName
        center.addObserver(self, selector: #selector(languageSwitched(_:)), name: languageSwitched, object: nil)
    }
    
    @objc func languageSwitched(_ sender: Notification){
        setUI()
    }
}
