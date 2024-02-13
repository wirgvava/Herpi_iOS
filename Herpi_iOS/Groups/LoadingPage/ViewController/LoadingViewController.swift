//
//  LoadingViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 10.02.24.
//

import UIKit

class LoadingViewController: UIViewController {
    
//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }
    
    deinit {
        unsubscribe()
    }
    
//  MARK: - Methods
    func unsubscribe(){
        let center = NotificationCenter.default
        center.removeObserver(self)
    }

    func subscribe(){
        let center = NotificationCenter.default
        let didLoadedData = Notifications.didLoadedData.notificationName
        center.addObserver(self, selector: #selector(openMainPage(_:)), name: didLoadedData, object: nil)
    }
    
    @objc func openMainPage(_ sender: Notification){
        let vc = UIStoryboard(name: MainViewController.className, bundle: nil).instantiateViewController(withIdentifier: "navController")
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = vc
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil)
        }
    }
}
