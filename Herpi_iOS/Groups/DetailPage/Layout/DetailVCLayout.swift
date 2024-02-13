//
//  DetailVCLayout.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import Foundation
import UIKit
import MapKit

class DetailVCLayout: NSObject {
    
    fileprivate weak var viewController: DetailViewController!
    
//  - Init
    init(viewController: DetailViewController!) {
        self.viewController = viewController
        super.init()
    }
}

// MARK: - Configure
extension DetailVCLayout {
    func configure(){
        setInfoCardHeight()
        setUI()
        checkVenom()
        setCollectionHeight()
        setupMapView()
    }
    
    private func setUI(){
        guard let vc = viewController else { return }
        guard let data = viewController.detailedInfo else { return }
        vc.photo.kf.setImage(with: URL(string: (data.image!)))
        vc.nameLbl.text = data.name
        vc.scientificNameLbl.text = data.scientificName
        vc.familyLbl.text = data.family?.name
        vc.authorAvatar.kf.setImage(with: URL(string: (data.addedBy?.avatar) ?? ""))
        
        let authorName = data.addedBy?.firstName ?? ""
        let authorLastname = data.addedBy?.lastName ?? ""
        vc.authorNameLbl.text = authorName + " " + authorLastname
        vc.descrLbl.text = data.description
        vc.infoCard.addShadow(shadowColor: .gray, shadowOpacity: 0.5, shadowOffset: CGSize(width: -1, height: -1), shadowRadius: 8)
        
        let attrString = NSAttributedString(string: "რუკის გაშლა", attributes: [.font : UIFont.herpi(type: .semiBold, size: 16)])
        vc.openMapBtn.setAttributedTitle(attrString, for: .normal)
        vc.openMapBtn.addShadow(shadowColor: .black, shadowOpacity: 0.8, shadowOffset: CGSize(width: -1, height: -1), shadowRadius: 8)
    }
    
    private func checkVenom(){
        guard let vc = viewController else { return }
        guard let data = viewController.detailedInfo else { return }
        if data.venomous == true {
            vc.venomView.backgroundColor = Colors.venomType(.venomous)
            vc.venomInfoLbl.text = "შხამიანი"
        } else if data.hasMildVenom == true {
            vc.venomView.backgroundColor = Colors.venomType(.midVenom)
            vc.venomInfoLbl.text = "სუსტად შხამიანი"
        } else {
            vc.venomView.backgroundColor = Colors.venomType(.noVenom)
            vc.venomInfoLbl.text = "უშხამო"
        }
    }
    
    private func setInfoCardHeight(){
        guard let vc = viewController else { return }
        guard let data = viewController.detailedInfo else { return }

        if data.hasRedFlag == true  {
            vc.refFlagViewHeightConstraint.constant = 80
        } else {
            vc.refFlagViewHeightConstraint.constant = 0
        }
    }
    
    private func setCollectionHeight(){
        guard let gallery = viewController.detailedInfo?.gallery else { return }
        
        if gallery.count <= 2 {
            viewController.galleryCollectionHeight.constant = 120
        } else {
            viewController.galleryCollectionHeight.constant = 260
        }
    }
}

// MARK: - Setup MapView
extension DetailVCLayout: MKMapViewDelegate {
    func setupMapView() {
        viewController.mapView.delegate = self
        
        // Coordinates to define the coverage area
        var formatedCoordinates: [CLLocationCoordinate2D] = []
        var coverageCoordinates: [Coordinate] = []
        
        for coverage in viewController.coverage {
            coverageCoordinates = coverage.coordinates
        }
        
        for coordinate in coverageCoordinates {
            let lat = coordinate.lat
            let lng = coordinate.lng
            formatedCoordinates.append(CLLocationCoordinate2D(latitude: lat, longitude: lng))
        }
        
        // Create MKPolygon with the defined coordinates
        let polygon = MKPolygon(coordinates: formatedCoordinates)
        
        // Add the polygon as an overlay on the map
        viewController.mapView.addOverlay(polygon)
        
        let location = CLLocationCoordinate2D(latitude: 42.054490, longitude: 43.728376)
        let span = MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
        let region = MKCoordinateRegion(center: location, span: span)
        viewController.mapView.setRegion(region, animated: true)
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

// MARK: - Navigation
extension DetailVCLayout {
    func openMap(){
        var coverageCoordinates: [Coordinate] = []
        for coverage in viewController.coverage { coverageCoordinates = coverage.coordinates }
        
        let mapVC = UIStoryboard(name: CoverageMapViewController.className, bundle: nil).instantiateViewController(withIdentifier: "mapVC") as! CoverageMapViewController
        mapVC.coverageCoordinates = coverageCoordinates
        viewController.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func shareAction(){
        guard let reptileId = viewController.detailedInfo?.id else { return }
        let url = Constants.shareURL(for: reptileId)
        if let link = NSURL(string: url) {
            let objectsToShare = [link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            viewController.present(activityVC, animated: true)
        }
    }
}
