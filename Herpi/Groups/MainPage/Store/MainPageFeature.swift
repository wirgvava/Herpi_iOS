//
//  MainPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import HerpiModels
import CoreLocation
import ComposableArchitecture

extension MainPageView {
    @Reducer
    struct Feature {

        // MARK: - State
        @ObservableState
        struct State: Equatable {
            var categories: CategoriesModel = mockCategories
            var selectedCategory: String = mockCategories.first?.titleTurned ?? .empty

            var nearbyReptiles = NearbyReptilesFeature.State()

            var reptiles = ReptilesListFeature.State(
                selectedCategory: mockCategories.first?.titleTurned ?? .empty
            )
            
            var latitude: Double = .zero
            var longitude: Double = .zero
            var currentLocationString: String = .empty
            var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
            var pickLocationSheetPresented: Bool = false
        }

        // MARK: - Action
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            case push(NavigationFeature.Path.State)

            case searchTapped
            case categorySelected(String)
            case presentPickLocationSheet
            case dismissPickLocationSheet
            
            case requestLocationPermission
            case locationAuthorizationChanged(CLAuthorizationStatus)
            case locationUpdated(latitude: Double, longitude: Double)
            case reverseGeocodeLocation(latitude: Double, longitude: Double)
            case reverseGeocodeResponse(String)
            case reverseGeocodeFailed

            case nearbyReptiles(NearbyReptilesFeature.Action)
            case reptilesList(ReptilesListFeature.Action)
        }
        
        // MARK: - Dependencies
        @Dependency(\.locationClient) var locationClient

        var body: some Reducer<State, Action> {
            BindingReducer()

            Reduce { state, action in
                switch action {
                case .binding:
                    return .none

                case .push:
                    return .none

                // MARK: UI Actions
                case .searchTapped:
                    return .send(.push(.search(SearchPageFeature.State())))

                case .categorySelected(let category):
                    state.selectedCategory = category
                    state.reptiles.selectedCategory = category
                    return .none
                    
                case .presentPickLocationSheet:
                    state.pickLocationSheetPresented = true
                    return .none
                    
                case .dismissPickLocationSheet:
                    state.pickLocationSheetPresented = false
                    return .none
                    
                case .requestLocationPermission:
                    return .run { send in
                        let status = await locationClient.authorizationStatus()
                        await send(.locationAuthorizationChanged(status))
                        
                        // Set up delegate stream FIRST before requesting anything
                        let delegateStream = await locationClient.delegate()
                        
                        if status == .notDetermined {
                            await locationClient.requestWhenInUseAuthorization()
                        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
                            // Already authorized, request location immediately
                            await locationClient.requestLocation()
                        }
                        
                        for await event in delegateStream {
                            switch event {
                            case .didChangeAuthorization(let newStatus):
                                await send(.locationAuthorizationChanged(newStatus))
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
                    
                case .locationAuthorizationChanged(let status):
                    state.locationAuthorizationStatus = status
                    return .none
                    
                case .locationUpdated(let latitude, let longitude):
                    state.latitude = latitude
                    state.longitude = longitude
                    return .send(.reverseGeocodeLocation(latitude: latitude, longitude: longitude))
                    
                case .reverseGeocodeLocation(let latitude, let longitude):
                    return .run { send in
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
                    
                case .reverseGeocodeResponse(let locationString):
                    state.currentLocationString = locationString
                    return .none
                    
                case .reverseGeocodeFailed:
                    state.currentLocationString = L.MainPage.Header.pickLocation
                    return .none

                // MARK: Child features
                case .nearbyReptiles(.didTappedReptileCard(let id)):
                     return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))

                case .nearbyReptiles:
                    return .none

                case .reptilesList(.didTappedReptileCard(let id)):
                     return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))

                case .reptilesList:
                    return .none
                }
            }

            // MARK: - Child reducers
            Scope(
                state: \.nearbyReptiles,
                action: \.nearbyReptiles
            ) {
                NearbyReptilesFeature()
            }

            Scope(
                state: \.reptiles,
                action: \.reptilesList
            ) {
                ReptilesListFeature()
            }
        }
    }
}
