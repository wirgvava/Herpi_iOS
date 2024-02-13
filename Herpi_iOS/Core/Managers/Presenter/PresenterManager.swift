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
        case searchPage
        case chooseLocationPage
        case detailPage
    }

    func navigate(from self: UIViewController, to vc: vc){
        var viewController: UIViewController
        
        switch vc {
        case .mainPage:
            viewController = UIStoryboard(name: MainViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .searchPage:
            viewController = UIStoryboard(name: SearchViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .chooseLocationPage:
            viewController = UIStoryboard(name: ChooseLocationViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .detailPage:
            viewController = UIStoryboard(name: DetailViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func present(from self: UIViewController, _ vc: vc, style: UIModalPresentationStyle){
        var viewController: UIViewController
        
        switch vc {
        case .mainPage:
            viewController = UIStoryboard(name: MainViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .searchPage:
            viewController = UIStoryboard(name: SearchViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .chooseLocationPage:
            viewController = UIStoryboard(name: ChooseLocationViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        case .detailPage:
            viewController = UIStoryboard(name: DetailViewController.className, bundle: nil).instantiateViewController(withIdentifier: vc.rawValue)
        }
        
        viewController.modalPresentationStyle = style
        self.present(viewController, animated: true)
    }
    
    func pop(_ vc: UIViewController){
        vc.navigationController?.popViewController(animated: true)
    }
}
