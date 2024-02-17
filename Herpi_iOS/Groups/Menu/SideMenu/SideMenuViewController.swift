//
//  SideMenuViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 16.02.24.
//

import UIKit
import Reachability

protocol MenuDelegate: AnyObject {
    func openMainPage()
    func openContactPage()
    func openTeamPage()
    func openFaqPage()
    func didChangedLanguage()
}

class SideMenuViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet private weak var decorBubble1: UIView!
    @IBOutlet private weak var decorBubble2: UIView!
    @IBOutlet private weak var decorBubble3: UIView!
    @IBOutlet private weak var decorBubble4: UIView!
    @IBOutlet weak var languageSwitcher: UISegmentedControl!
    // Buttons
    @IBOutlet weak var mainBtn: UIButton!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var teamBtn: UIButton!
    @IBOutlet weak var faqBtn: UIButton!
    
    // Delegate
    weak var delegate: MenuDelegate?
    
    fileprivate let reachability = try! Reachability()
    
    var currentPage: CurrentPage = .main {
        didSet {
            self.setButtonColors()
        }
    }
    
    enum CurrentPage {
        case main
        case contact
        case team
        case faq
    }
    
//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        set()
    }
    
//  MARK: - IBActions
    @IBAction func mainButtonAction(){
        delegate?.openMainPage()
    }
    
    @IBAction func contactButtonAction(){
        delegate?.openContactPage()
    }
    
    @IBAction func teamButtonAction(){
        delegate?.openTeamPage()
    }
    
    @IBAction func faqButtonAction(){
        delegate?.openFaqPage()
    }
    
    @IBAction func languageSwitchAction(){
        delegate?.didChangedLanguage()
    }
    
//  MARK: - Set
    func set(){
        decorationConfigure()
        languageSwitcherConfigure()
        setButtonColors()
    }
//  MARK: - Methods
    private func decorationConfigure(){
        decorBubble1.layer.masksToBounds = true
        decorBubble2.layer.masksToBounds = true
        decorBubble3.layer.masksToBounds = true
        decorBubble4.layer.masksToBounds = true
        decorBubble1.layer.cornerRadius = decorBubble1.frame.height / 2
        decorBubble2.layer.cornerRadius = decorBubble2.frame.height / 2
        decorBubble3.layer.cornerRadius = decorBubble3.frame.height / 2
        decorBubble4.layer.cornerRadius = decorBubble4.frame.height / 2
    }
    
    private func languageSwitcherConfigure(){
        if reachability.connection != .unavailable {
            let selectedColor = UIColor(red: 255/255, green: 227/255, blue: 179/255, alpha: 1)
            languageSwitcher.setTitleTextAttributes(
                [.foregroundColor : selectedColor,
                 .font : UIFont.herpi(type: .semiBold, size: 16)], for: .selected)
            
            languageSwitcher.setTitleTextAttributes(
                [.foregroundColor : UIColor.white,
                 .font : UIFont.herpi(type: .semiBold, size: 16)], for: .normal)
            
            let currentLanguage = UserDefaultsManager.shared.get(data: .language)
            
            if currentLanguage == "ka" {
                languageSwitcher.selectedSegmentIndex = 0
            } else {
                languageSwitcher.selectedSegmentIndex = 1
            }
            
            languageSwitcher.layer.isHidden = false
            languageSwitcher.layer.masksToBounds = true
            languageSwitcher.layer.cornerRadius = languageSwitcher.frame.height / 2
        } else {
            languageSwitcher.layer.isHidden = true
        }
    }
    
    private func setButtonColors(){
        switch currentPage {
        case .main:
            mainBtn.tintColor = Colors.menuBtnSelected
            contactBtn.tintColor = Colors.white
            teamBtn.tintColor = Colors.white
            faqBtn.tintColor = Colors.white
        case .contact:
            mainBtn.tintColor = Colors.white
            contactBtn.tintColor = Colors.menuBtnSelected
            teamBtn.tintColor = Colors.white
            faqBtn.tintColor = Colors.white
        case .team:
            mainBtn.tintColor = Colors.white
            contactBtn.tintColor = Colors.white
            teamBtn.tintColor = Colors.menuBtnSelected
            faqBtn.tintColor = Colors.white
        case .faq:
            mainBtn.tintColor = Colors.white
            contactBtn.tintColor = Colors.white
            teamBtn.tintColor = Colors.white
            faqBtn.tintColor = Colors.menuBtnSelected
        }
    }
}
