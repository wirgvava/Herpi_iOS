//
//  ChooseLocationFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 28.02.26.
//

import SwiftUI
import MapKit
import ComposableArchitecture

@Reducer
struct ChooseLocationFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var latitude: Double
        var longitude: Double
        var currentLocationString: String
        var annotationCoordinate: CLLocationCoordinate2D?
        var selectedDetent: PresentationDetent = .medium
        
        static func == (lhs: State, rhs: State) -> Bool {
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude &&
            lhs.currentLocationString == rhs.currentLocationString &&
            lhs.annotationCoordinate?.latitude == rhs.annotationCoordinate?.latitude &&
            lhs.annotationCoordinate?.longitude == rhs.annotationCoordinate?.longitude &&
            lhs.selectedDetent == rhs.selectedDetent
        }
    }
    
    // MARK: - Action
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case mapTapped(CLLocationCoordinate2D)
        case reverseGeocodeResponse(String, CLLocationCoordinate2D)
        case reverseGeocodeFailed
    }
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case let .mapTapped(coordinate):
                state.annotationCoordinate = coordinate
                return .run { send in
                    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    let geocoder = CLGeocoder()
                    
                    do {
                        let placemarks = try await geocoder.reverseGeocodeLocation(location)
                        if let placemark = placemarks.first {
                            let locationString = formatPlacemark(placemark, withStreetName: true)
                            await send(.reverseGeocodeResponse(locationString, coordinate))
                        } else {
                            await send(.reverseGeocodeFailed)
                        }
                    } catch {
                        await send(.reverseGeocodeFailed)
                    }
                }
                
            case let .reverseGeocodeResponse(locationString, coordinate):
                state.currentLocationString = locationString
                state.latitude = coordinate.latitude
                state.longitude = coordinate.longitude
                return .none
                
            case .reverseGeocodeFailed:
                state.currentLocationString = .empty
                return .none
            }
        }
    }
}
