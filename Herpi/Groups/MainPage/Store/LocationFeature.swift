//
//  LocationFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import CoreLocation
import ComposableArchitecture

extension MainPageView {
    @Reducer
    struct LocationFeature {
        
        // MARK: - State
        @ObservableState
        struct State: Equatable {
            var latitude: Double = .zero
            var longitude: Double = .zero
            var currentLocationString: String = .empty
            var authorizationStatus: CLAuthorizationStatus = .notDetermined
            var isPickLocationSheetPresented: Bool = false
            var isDisabledLocationAlertPresented: Bool = false
        }
        
        // MARK: - Action
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            
            // UI Actions
            case setPickLocationSheetPresented(Bool)
            case setDisabledLocationAlertPresented(Bool)
            case openSystemSettings
            
            // Location Actions
            case requestPermission
            case authorizationChanged(CLAuthorizationStatus)
            case locationUpdated(latitude: Double, longitude: Double)
            case reverseGeocode(latitude: Double, longitude: Double)
            case reverseGeocodeResponse(String)
            case reverseGeocodeFailed
        }
        
        // MARK: - Dependencies
        @Dependency(\.openURL) var openURL
        @Dependency(\.locationClient) var locationClient
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            
            Reduce { state, action in
                switch action {
                case .binding:
                    return .none
                    
                    // MARK: UI Actions
                case .setPickLocationSheetPresented(let isPresented):
                    state.isPickLocationSheetPresented = isPresented
                    return .none
                    
                case .setDisabledLocationAlertPresented(let isPresented):
                    AppAnalytics.log(AppAnalytics.NearbySpecies.notFound(reason: .locationOff))
                    state.isDisabledLocationAlertPresented = isPresented
                    return .none
                    
                case .openSystemSettings:
                    return .run { _ in
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            await openURL(url)
                        }
                    }
                    
                    // MARK: Location Actions
                case .requestPermission:
                    return .run { send in
                        await handleLocationPermission(send)
                    }
                    
                case .authorizationChanged(let status):
                    state.authorizationStatus = status
                    return .none
                    
                case .locationUpdated(let latitude, let longitude):
                    state.latitude = latitude
                    state.longitude = longitude
                    
                    // Save location for next app launch
                    UserDefaultsManager.shared.set(latitude, forKey: .lastLatitude)
                    UserDefaultsManager.shared.set(longitude, forKey: .lastLongitude)
                    
                    return .send(.reverseGeocode(latitude: latitude, longitude: longitude))
                    
                case .reverseGeocode(let latitude, let longitude):
                    return .run { send in
                        await performReverseGeocode(send, latitude: latitude, longitude: longitude)
                    }
                    
                case .reverseGeocodeResponse(let locationString):
                    state.currentLocationString = locationString
                    return .none
                    
                case .reverseGeocodeFailed:
                    state.currentLocationString = L.MainPage.Header.pickLocation
                    return .none
                }
            }
        }
        
        // MARK: - Private Helpers
        private func handleLocationPermission(_ send: Send<Action>) async {
            let status = await locationClient.authorizationStatus()
            await send(.authorizationChanged(status))
            
            let delegateStream = await locationClient.delegate()
            
            switch status {
            case .notDetermined:
                await locationClient.requestWhenInUseAuthorization()
                
            case .authorizedWhenInUse, .authorizedAlways:
                await locationClient.requestLocation()
                
            case .denied, .restricted:
                await send(.setDisabledLocationAlertPresented(true))
                
            @unknown default:
                break
            }
            
            for await event in delegateStream {
                switch event {
                case .didChangeAuthorization(let newStatus):
                    await send(.authorizationChanged(newStatus))
                    if newStatus == .authorizedWhenInUse || newStatus == .authorizedAlways {
                        await locationClient.requestLocation()
                    }
                case .didUpdateLocations(let coordinates):
                    if let coordinate = coordinates.last {
                        await send(.locationUpdated(
                            latitude: coordinate.lat,
                            longitude: coordinate.lng
                        ))
                    }
                case .didFailWithError:
                    break
                }
            }
        }
        
        private func performReverseGeocode(_ send: Send<Action>, latitude: Double, longitude: Double) async {
            let location = CLLocation(latitude: latitude, longitude: longitude)
            let geocoder = CLGeocoder()
            
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first {
                    let locationString = formatPlacemark(placemark)
                    await send(.reverseGeocodeResponse(locationString))
                } else {
                    await send(.reverseGeocodeFailed)
                }
            } catch {
                await send(.reverseGeocodeFailed)
            }
        }
    }
}
