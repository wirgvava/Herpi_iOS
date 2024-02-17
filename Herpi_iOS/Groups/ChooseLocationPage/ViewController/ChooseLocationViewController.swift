//
//  ChooseLocationViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit
import MapKit

class ChooseLocationViewController: UIViewController, UISheetPresentationControllerDelegate {
    
//  MARK: - IBOutlets
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var currentLocationLbl: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    // Managers
    private var layout: ChooseLocationVCLayout?
    
    // Current location
    var lat = 0.0
    var lng = 0.0
    var currentLocation = ""
    
    // Delegate
    weak var delegate: LocationDelegate?
    
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removePanGesture(on: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addPanGesture(on: self)
    }
   
//  MARK: - IBActions
    @IBAction func didTapCancelBtn(){
        self.dismiss(animated: true)
    }
    
    @IBAction func didTapAcceptBtn(){
        delegate?.didChangedLocationWith(lat: lat, lng: lng, name: currentLocationLbl.text ?? "")
        self.dismiss(animated: true)
    }
}

// MARK: - Configure
extension ChooseLocationViewController {
    private func configure(){
        setLayout()
        setMapKit()
    }
    
    private func setLayout(){
        layout = ChooseLocationVCLayout(viewController: self)
    }
}

// MARK: - Map
extension ChooseLocationViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    private func setMapKit(){
        let initialLocation = CLLocationCoordinate2D(latitude: lat,longitude: lng)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let initialRegion = MKCoordinateRegion(center: initialLocation, span: span)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setRegion(initialRegion, animated: true)
        
        let gestureZ = UITapGestureRecognizer(target: self, action: #selector(self.revealRegionDetailsWithLongPressOnMap(sender:)))
        mapView.addGestureRecognizer(gestureZ)
    }
    
    @IBAction func revealRegionDetailsWithLongPressOnMap(sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: mapView)
        let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)

        // Remove existing pins
        mapView.removeAnnotations(mapView.annotations)
        
        // Add a new pin
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
        // Perform reverse geocoding to get location name
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                showError(message: error, sender: self)
            } else if let placemark = placemarks?.first {
                self.fillInfo(with: placemark, coordinate: coordinate)
            }
        }
    }
    
    private func fillInfo(with placeMark: CLPlacemark, coordinate: CLLocationCoordinate2D){
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
            self.currentLocationLbl.text = ""
        } else {
            self.currentLocationLbl.text = streetName + city + country
        }
        
        self.lat = coordinate.latitude
        self.lng = coordinate.longitude
    }
}
