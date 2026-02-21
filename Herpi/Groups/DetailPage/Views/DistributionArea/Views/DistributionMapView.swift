//
//  DistributionMapView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 20.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import MapKit

struct DistributionMapView: UIViewRepresentable {
    let region: MKCoordinateRegion
    let coverage: CoverageModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: .realistic)
        mapView.setRegion(region, animated: false)
        mapView.isScrollEnabled = true
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        mapView.isPitchEnabled = false
        mapView.showsScale = false
        mapView.showsUserLocation = false
        
        addPolygons(to: mapView)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeOverlays(uiView.overlays)
        addPolygons(to: uiView)
    }
    
    private func addPolygons(to mapView: MKMapView) {
        for coverageElement in coverage {
            let coordinates = coverageElement.coordinates.map {
                CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng)
            }
            let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
            mapView.addOverlay(polygon)
        }
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polygon = overlay as? MKPolygon {
                let renderer = MKPolygonRenderer(polygon: polygon)
                renderer.fillColor = UIColor(HerpiColor.VenomType.venomous).withAlphaComponent(0.3)
                renderer.strokeColor = UIColor(HerpiColor.VenomType.venomous)
                renderer.lineWidth = .one
                return renderer
            }
            return MKOverlayRenderer()
        }
    }
}
