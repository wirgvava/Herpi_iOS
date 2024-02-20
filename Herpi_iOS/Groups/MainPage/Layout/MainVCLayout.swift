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
    func configure(){
        setupRefreshController()
        setupLocalizedTexts()
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
        refreshControl.attributedTitle = NSAttributedString(string: "loading".localized, attributes: attributes)
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        viewController.scrollView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        AppDelegate.shared.getData()
        viewController.scrollView.reloadInputViews()
        refreshControl.endRefreshing()
    }
    
    private func setupLocalizedTexts(){
        viewController.searchBarLbl.text = "search.bar".localized
        viewController.nearYouLbl.text = "nearby.header".localized
        viewController.nearYouDescription.text = "nearby.description".localized
    }
}

// MARK: - Navigation
extension MainVCLayout {
    func openLocationSheet(){
        let locationSheet = UIStoryboard(name: ChooseLocationViewController.className, bundle: nil).instantiateViewController(withIdentifier: "chooseLocationPage") as! ChooseLocationViewController
        
        locationSheet.delegate = viewController
        locationSheet.lat = viewController.lat
        locationSheet.lng = viewController.lng
        locationSheet.currentLocation = viewController.currentLocationLbl.text ?? ""
        locationSheet.modalPresentationStyle = .automatic
        viewController.present(locationSheet, animated: true)
    }
    
    func showLocationIsDisabledAlert(){
        let locationIsDisabledSheet = UIStoryboard(name: LocationIsDisabledSheet.className, bundle: nil).instantiateViewController(withIdentifier: "locationIsDisabledPage") as! LocationIsDisabledSheet
        locationIsDisabledSheet.modalPresentationStyle = .automatic
        viewController.present(locationIsDisabledSheet, animated: true)
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
            viewController.emptyNearbyList.text = "empty.nearby.location.is.disabled".localized
            showLocationIsDisabledAlert()
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
        viewController.emptyNearbyList.text = "empty.nearby.list".localized
    
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
            viewController.currentLocationLbl.text = "set.location.manually".localized
        } else {
            viewController.currentLocationLbl.text = streetName + city + country
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError(message: error, sender: viewController)
    }
}
