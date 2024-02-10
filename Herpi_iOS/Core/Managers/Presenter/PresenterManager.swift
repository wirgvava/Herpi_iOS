//
//  PresenterManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 10.02.24.
//

import UIKit

class PresenterManager {
    
    static let shared = PresenterManager()
       
    enum vc: String {
        case mainPage
    }

    func navigate(to vc: vc){
        var viewController: UIViewController
        
        switch vc {
        case .mainPage:
            viewController = UIStoryboard(name: MainViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        }
       
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = viewController
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
