//
//  ChooseLocationMapView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 28.02.26.
//

import SwiftUI
import MapKit

extension ChooseLocationSheet {
    struct MapView: UIViewRepresentable {
        var latitude: Double
        var longitude: Double
        var annotationCoordinate: CLLocationCoordinate2D?
        var onTap: (CLLocationCoordinate2D) -> Void
        
        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.delegate = context.coordinator
            mapView.showsUserLocation = true
            
            let initialLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            let initialRegion = MKCoordinateRegion(center: initialLocation, span: span)
            mapView.setRegion(initialRegion, animated: false)
            
            let tapGesture = UITapGestureRecognizer(
                target: context.coordinator,
                action: #selector(Coordinator.handleTap(_:))
            )
            mapView.addGestureRecognizer(tapGesture)
            
            return mapView
        }
        
        func updateUIView(_ mapView: MKMapView, context: Context) {
            // Update annotations
            mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
            
            if let coordinate = annotationCoordinate {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                mapView.addAnnotation(annotation)
            }
        }
        
        func makeCoordinator() -> Coordinator {
            Coordinator(onTap: onTap)
        }
        
        class Coordinator: NSObject, MKMapViewDelegate {
            var onTap: (CLLocationCoordinate2D) -> Void
            weak var mapView: MKMapView?
            
            init(onTap: @escaping (CLLocationCoordinate2D) -> Void) {
                self.onTap = onTap
            }
            
            @objc func handleTap(_ sender: UITapGestureRecognizer) {
                guard let mapView = sender.view as? MKMapView else { return }
                let touchLocation = sender.location(in: mapView)
                let coordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
                onTap(coordinate)
            }
        }
    }
}
