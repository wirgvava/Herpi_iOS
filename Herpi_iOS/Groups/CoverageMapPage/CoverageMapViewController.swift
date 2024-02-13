//
//  CoverageMapViewController.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import UIKit
import MapKit

class CoverageMapViewController: UIViewController {
    
//  MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeButton: UIButton!
    
    var coverageCoordinates: [Coordinate] = []
    
//  MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupMapView()
    }
    
//  MARK: - IBActions
    @IBAction func didTapCloseButton(){
        PresenterManager.shared.pop(self)
    }
    
    func configure(){
        let attrString = NSAttributedString(string: "დახურვა", attributes: [.font : UIFont.herpi(type: .semiBold, size: 16)])
        closeButton.setAttributedTitle(attrString, for: .normal)
    }
}

// MARK: - Setup MapView
extension CoverageMapViewController: MKMapViewDelegate {
    func setupMapView() {
        mapView.delegate = self
        
        // Coordinates to define the coverage area
        var formatedCoordinates: [CLLocationCoordinate2D] = []
        
        for coordinate in coverageCoordinates {
            let lat = coordinate.lat
            let lng = coordinate.lng
            formatedCoordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
        
        // Create MKPolygon with the defined coordinates
        let polygon = MKPolygon(coordinates: formatedCoordinates)
        
        // Add the polygon as an overlay on the map
        mapView.addOverlay(polygon)
        
        let location = CLLocationCoordinate2D(latitude: 42.054490, longitude: 43.728376)
        let span = MKCoordinateSpan(latitudeDelta: 8, longitudeDelta: 8)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polygon = overlay as? MKPolygon {
            let renderer = MKPolygonRenderer(polygon: polygon)
            renderer.fillColor = Colors.venomType(.venomous).withAlphaComponent(0.3)
            renderer.strokeColor = Colors.venomType(.venomous)
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}
