//
//  NearbyReptilesFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 24.01.26.
//

import ComposableArchitecture
import HerpiModels

@Reducer
struct NearbyReptilesFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var reptiles: NearbyReptilesModel = []
        var currentPage: Int = .zero
        var isLoading: Bool = false
        var latitude: Double = .zero
        var longitude: Double = .zero
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case fetchReptiles
        case pageChanged(Int)
        case reptilesResponse(NearbyReptilesModel)
        case didFailWithError(String)
        case didTappedReptileCard(Int)
    }
    
    // MARK: - Dependencies
    @Dependency(\.apiClient) var apiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchReptiles:
                let lat = state.latitude
                let lng = state.longitude
                state.isLoading = true
                
                return .run { send in
                    let reptiles = try await apiClient.fetchNearbyReptiles(lat: lat, lng: lng)
                    await send(.reptilesResponse(reptiles))
                } catch: { error, send in
                    await send(.didFailWithError(error.localizedDescription))
                }
                
            case let .reptilesResponse(reptiles):
                state.isLoading = false
                state.reptiles = reptiles
                state.currentPage = .zero
                return .none
                
            case let .pageChanged(page):
                state.currentPage = page
                return .none
                
            case .didTappedReptileCard, .didFailWithError:
                return .none
            }
        }
    }
}
