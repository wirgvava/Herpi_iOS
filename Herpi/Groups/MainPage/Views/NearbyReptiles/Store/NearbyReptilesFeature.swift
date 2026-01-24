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
    
    @ObservableState
    struct State: Equatable {
        var reptiles: NearbyReptilesModel = []
        var currentPage: Int = .zero
        var isLoading: Bool = false
    }
    
    enum Action: Equatable {
        case fetchReptiles
        case pageChanged(Int)
        case reptilesResponse(NearbyReptilesModel)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchReptiles:
                state.isLoading = true
                return .run { send in
                    let reptiles: NearbyReptilesModel = [
                        mockNearbyReptile1, mockNearbyReptile2, mockNearbyReptile3, mockNearbyReptile4, mockNearbyReptile5, mockNearbyReptile6, mockNearbyReptile7, mockNearbyReptile8
                    ]
                    await send(.reptilesResponse(reptiles))
                }
                
            case let .reptilesResponse(reptiles):
                state.isLoading = false
                state.reptiles = reptiles
                state.currentPage = .zero
                return .none
                
            case let .pageChanged(page):
                state.currentPage = page
                return .none
            }
        }
    }
}
