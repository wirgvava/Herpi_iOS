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
        PresenterManager.shared.navigate(to: .mainPage)
    }
}
