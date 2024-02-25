//
//  DetailVCLayout.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import UIKit
import MapKit
import Reachability
import GoogleMobileAds

class DetailVCLayout: NSObject {
    
    fileprivate weak var viewController: DetailViewController!
    fileprivate let reachability = try! Reachability()
    
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
        setAdBanners()
        loadIntersisialAd()
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
        vc.openMapBtn.setAttrString(string: "detailed.openMap.button".localized, fontSize: 16)
        vc.openMapBtn.addShadow(shadowColor: .black, shadowOpacity: 0.8, shadowOffset: CGSize(width: -1, height: -1), shadowRadius: 8)
        vc.infoCard.addShadow(shadowColor: .gray, shadowOpacity: 0.5, shadowOffset: CGSize(width: -1, height: -1), shadowRadius: 8)
    }
    
    private func checkVenom(){
        guard let vc = viewController else { return }
        guard let data = viewController.detailedInfo else { return }
        if data.venomous == true {
            vc.venomView.backgroundColor = Colors.venomType(.venomous)
            vc.venomInfoLbl.text = "venomous".localized
        } else if data.hasMildVenom == true {
            vc.venomView.backgroundColor = Colors.venomType(.midVenom)
            vc.venomInfoLbl.text = "mid.venomous".localized
        } else {
            vc.venomView.backgroundColor = Colors.venomType(.noVenom)
            vc.venomInfoLbl.text = "no.venomous".localized
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

// MARK: - setup Ads
extension DetailVCLayout {
    private func setAdBanners(){
        guard let vc = viewController else { return }
        if reachability.connection == .unavailable {
            vc.adBanner_1.layer.isHidden = true
            vc.adBanner_2.layer.isHidden = true
            vc.adBanner_3.layer.isHidden = true
        } else {
            vc.adBanner_1.layer.isHidden = false
            vc.adBanner_2.layer.isHidden = false
            vc.adBanner_3.layer.isHidden = false
            vc.bannerView_1 = GADBannerView(adSize: GADAdSizeBanner)
            addBannerView(to: vc.adBanner_1, rootVC: vc, bannerView: vc.bannerView_1)
            vc.bannerView_2 = GADBannerView(adSize: GADAdSizeBanner)
            addBannerView(to: vc.adBanner_2, rootVC: vc, bannerView: vc.bannerView_2)
            vc.bannerView_3 = GADBannerView(adSize: GADAdSizeBanner)
            vc.bannerView_1.delegate = self
            vc.bannerView_2.delegate = self
            vc.bannerView_3.delegate = self
            addBannerView(to: vc.adBanner_3, rootVC: vc, bannerView: vc.bannerView_3)
        }
    }
    
    private func loadIntersisialAd(){
        let request = GADRequest()
        let adUnitID = Bundle.main.infoDictionary?["GADInterstitialID"] as? String ?? ""
        guard let vc = viewController else { return }

        GADInterstitialAd.load(withAdUnitID: adUnitID, request: request) { ad, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let ad = ad {
                vc.interstitial = ad
            }
        }
    }
}

// MARK: - Ad appears only if loaded
extension DetailVCLayout: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        // Ad loaded successfully
        viewController.adBanner_1.layer.isHidden = false
        viewController.adBanner_2.layer.isHidden = false
        viewController.adBanner_3.layer.isHidden = false
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        // Failed to load ad
        viewController.adBanner_1.layer.isHidden = true
        viewController.adBanner_2.layer.isHidden = true
        viewController.adBanner_3.layer.isHidden = true
    }
}

// MARK: - Navigation
extension DetailVCLayout {
    func openMap(){
        var coverageCoordinates: [Coordinate] = []
        for coverage in viewController.coverage { coverageCoordinates = coverage.coordinates }
        let specieId = viewController.detailedInfo?.id
        let mapVC = UIStoryboard(name: CoverageMapViewController.className, bundle: nil).instantiateViewController(withIdentifier: "mapVC") as! CoverageMapViewController
        mapVC.coverageCoordinates = coverageCoordinates
        AppAnalytics.logEvents(with: .expand_distribution_map, paramName: .specie_id, paramData: specieId)
        
        if viewController.interstitial != nil {
            viewController.interstitial?.present(fromRootViewController: viewController)
        }
        viewController.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func shareAction(){
        guard let reptileId = viewController.detailedInfo?.id else { return }
        let url = Constants.shareURL(for: reptileId)
        if let link = NSURL(string: url) {
            let objectsToShare = [link]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            AppAnalytics.logEvents(with: .share, paramName: .specie_id, paramData: reptileId)
            viewController.present(activityVC, animated: true)
        }
    }
}
