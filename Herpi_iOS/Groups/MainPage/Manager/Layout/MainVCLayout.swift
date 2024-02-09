//
//  MainVCLayout.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import UIKit
import CoreLocation

class MainVCLayout: NSObject {
    
    fileprivate weak var viewController: MainViewController!
    fileprivate weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    let refreshControl = UIRefreshControl()
    
//  MARK: - Init
    init(viewController: MainViewController!, tableView: UITableView!) {
        self.viewController = viewController
        self.tableView = tableView
        super.init()
        configure()
    }
}

// MARK: - Configure
extension MainVCLayout {
    private func configure(){
        viewController.view.showAnimatedSkeleton()
        setupRefreshController()
        setTopCategoryViewHeight()
        setCollectionViewHeights()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        UserDefaultsManager.shared.save(value: true, data: .firstLoginSelected)
    }
    
    private func setupRefreshController(){
        let font = UIFont.herpi(type: .semiBold, size: 14)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: Colors.defaultDark!]
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.attributedTitle = NSAttributedString(string: "იტვირთება", attributes: attributes)
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        viewController.scrollView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        viewController.getReptilies()
        viewController.scrollView.reloadInputViews()
        refreshControl.endRefreshing()
    }
    
    func setTopCategoryViewHeight(){
        var totalHeightOfViews = 0.toCGFloat()
        viewController.topCategoryViews.forEach { view in
            totalHeightOfViews += view.frame.height
        }
        
        let totalTopCategoryHeight = totalHeightOfViews + 167
        viewController.topCategoriesHeight.constant = totalTopCategoryHeight
    }
    
    private func setCollectionViewHeights(){
        if let categoryCollectionViewLayout = viewController.categoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            categoryCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        if let nearbyCollectionViewLayout = viewController.nearbyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            nearbyCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
}

// MARK: - Navigation
extension MainVCLayout {
    func openMenu(){
        let menuView = MenuView.instantiateFromNib()
        guard let view = self.viewController.view else { return }
        menuView.delegate = self
        menuView.set()
        menuView.setupGestures(view: view)
        view.addSubview(menuView)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - Location
extension MainVCLayout: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            let coordinates = manager.location?.coordinate
            let lat = coordinates?.latitude ?? 0
            let lng = coordinates?.longitude ?? 0
            locationManager.startUpdatingLocation()
            viewController.getNearbyReptiles(lat: lat, lng: lng)
            viewController.emptyNearbyList.text = "ამ არეალში გავრცელებული სახეობები ვერ მოიძებნა"
        case .denied, .restricted:
            viewController.nearbyCollectionView.isHidden = true
            viewController.emptyNearbyList.isHidden = false
            locationManager.stopUpdatingLocation()
            viewController.emptyNearbyList.text = "შენს არეალში გავრცელებული სახეობების სანახავად გაგვიზიარე ადგილმდებარეობა ან მონიშნე ხელით. პრობლემის შემთხვევაში დაგვიკავშირდი"
            showInfo(message: "Check location settings", sender: viewController)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(message: error, sender: viewController)
    }
}

// MARK: - Menu Actions
extension MainVCLayout: MenuDelegate {
    func didTapContactButton() {
        print("Contact tapped")
    }
    
    func didTapTeamButton() {
        print("Team tapped")
    }
    
    func didTapFaqButton() {
        print("Faq tapped")
    }
    
    func didTapSettingsButton() {
        print("Settings tapped")
    }
    
    func didSwitchedLanguage() {
        print("language switched")
    }
}
