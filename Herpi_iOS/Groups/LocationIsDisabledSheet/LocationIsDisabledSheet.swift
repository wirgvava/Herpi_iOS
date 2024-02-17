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
        header.text = Localized.header
        descr.text = Localized.description
        
        let okAttrString = NSAttributedString(string: Localized.okBtn, attributes: [.font : UIFont.herpi(type: .semiBold, size: 15)])
        okBtn.setAttributedTitle(okAttrString, for: .normal)
        
        let settingsAttrString = NSAttributedString(string: Localized.settingsBtn, attributes: [.font : UIFont.herpi(type: .semiBold, size: 15)])
        settingsBtn.setAttributedTitle(settingsAttrString, for: .normal)
        okBtn.layer.cornerRadius = okBtn.frame.height / 2
        settingsBtn.layer.cornerRadius = settingsBtn.frame.height / 2
    }
    
    private enum Localized {
        static let header = "ადგილმდებარეობა გამორთულია"
        static let description = "თქვენი ადგილმდებარეობის დადგენა ვერ მოხერხდა, რადგან თქვენი GPS გამორთულია. ადგილმდებარეობის ინფორმაცია გამოიყენება თქვენს არეალში გავრცელებული სახეობების მოსაძებნად, შესაბამისად ამ ფუნქციით სარგებლობას ვერ შეძლებთ.\nადგილმდებარეობის ჩასართავად შეამოწმეთ ლოკაციის პარამეტრები"
        static let okBtn = "გასაგებია"
        static let settingsBtn = "პარამეტრები"
    }
}
