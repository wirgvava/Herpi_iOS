//
//  MenuView.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import UIKit

class MenuView: UIView {
    
//  MARK: - IBOutlets
    @IBOutlet weak var decorBubble1: UIView!
    @IBOutlet weak var decorBubble2: UIView!
    @IBOutlet weak var decorBubble3: UIView!
    @IBOutlet weak var decorBubble4: UIView!
    @IBOutlet weak var languageSwitcher: UISegmentedControl!
    
    weak var delegate: MenuDelegate?
    
//  MARK: - IBActions
    @IBAction func mainButtonAction(){
        self.removeFromSuperview()
    }
    
    @IBAction func contactButtonAction(){
        delegate?.didTapContactButton()
    }
    
    @IBAction func teamButtonAction(){
        delegate?.didTapTeamButton()
    }
    
    @IBAction func faqButtonAction(){
        delegate?.didTapFaqButton()
    }
    
    @IBAction func settingsAction(){
        delegate?.didTapSettingsButton()
    }
    
    @IBAction func languageSwitchAction(){
        delegate?.didSwitchedLanguage()
    }
    
//  MARK: - Set
    func set(){
        decorationConfigure()
        languageSwitcherConfigure()
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.decorBubble3.layer.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12){
            self.decorBubble2.layer.isHidden = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
            self.decorBubble1.layer.isHidden = false
        }
        

    }
    
    private func languageSwitcherConfigure(){
        let selectedColor = UIColor(red: 255/255, green: 227/255, blue: 179/255, alpha: 1)
        languageSwitcher.setTitleTextAttributes(
            [.foregroundColor : selectedColor,
             .font : UIFont.herpi(type: .semiBold, size: 16)], for: .selected)
        
        languageSwitcher.setTitleTextAttributes(
            [.foregroundColor : UIColor.white,
             .font : UIFont.herpi(type: .semiBold, size: 16)], for: .normal)
        
        languageSwitcher.layer.masksToBounds = true
        languageSwitcher.layer.cornerRadius = languageSwitcher.frame.height / 2
    }
}

// MARK: - Gestures
extension MenuView: UIGestureRecognizerDelegate {
    func setupGestures(view: UIView){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMenu))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissMenu(){
        self.removeFromSuperview()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self
    }
  
}
