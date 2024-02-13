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
        setupRefreshController()
        setTopCategoryViewHeight()
        setCollectionViewHeights()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        viewController.navigationController?.navigationBar.isHidden = true
        UserDefaultsManager.shared.save(value: true, forKey: .firstLoginSelected)
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
        AppDelegate.shared.getData()
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
    
    func openLocationSheet(){
        let locationSheet = UIStoryboard(name: ChooseLocationViewController.className, bundle: nil).instantiateViewController(withIdentifier: "chooseLocationPage") as! ChooseLocationViewController
        
        locationSheet.delegate = viewController
        locationSheet.lat = viewController.lat
        locationSheet.lng = viewController.lng
        locationSheet.currentLocation = viewController.currentLocationLbl.text ?? ""
        locationSheet.modalPresentationStyle = .automatic
        viewController.present(locationSheet, animated: true)
    }
}

// MARK: - Location
extension MainVCLayout: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
            viewController.nearbyCollectionView.isHidden = true
            viewController.emptyNearbyList.isHidden = false
            viewController.emptyNearbyList.text = "შენს არეალში გავრცელებული სახეობების სანახავად გაგვიზიარე ადგილმდებარეობა ან მონიშნე ხელით. პრობლემის შემთხვევაში დაგვიკავშირდი"
            showInfo(message: "Check location settings", sender: viewController)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let lat = location.coordinate.latitude
        let lng = location.coordinate.longitude
        viewController.lat = lat
        viewController.lng = lng
        viewController.getNearbyReptiles(lat: lat, lng: lng)
        viewController.emptyNearbyList.text = "ამ არეალში გავრცელებული სახეობები ვერ მოიძებნა"
    
        // Perform reverse geocoding to get location name
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                showError(message: error, sender: self.viewController)
            } else if let placemark = placemarks?.first {
                fillInfo(with: placemark)
                locationManager.stopUpdatingLocation()
            }
        }
    }
    
    private func fillInfo(with placeMark: CLPlacemark){
        var streetName = (placeMark.thoroughfare != nil) ? placeMark.thoroughfare! : ""
        let city = (placeMark.locality != nil) ? placeMark.locality! + " , " : ""
        let country = (placeMark.country != nil) ? placeMark.country! : ""
     
        if streetName.contains("Street") {
            streetName.removeLast(6)
            streetName.append("St. , ")
        } else if streetName != "" {
            streetName.append(" , ")
        }
        
        if streetName == "" && city == "" && country == "" {
            viewController.currentLocationLbl.text = "Please enter location manually."
        } else {
            viewController.currentLocationLbl.text = streetName + city + country
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