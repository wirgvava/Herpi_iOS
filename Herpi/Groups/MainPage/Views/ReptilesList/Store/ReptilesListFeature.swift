//
//  ReptilesListFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 25.01.26.
//

import ComposableArchitecture
import HerpiModels

@Reducer
struct ReptilesListFeature {
    
    @ObservableState
    struct State: Equatable {
        var reptiles: ReptilesModel = []
        var selectedCategory: String
        var isLoading: Bool = false
    }
    
    enum Action: Equatable {
        case fetchReptiles
        case reptilesResponse(ReptilesModel)
        case didTappedReptileCard(Int)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchReptiles:
                state.isLoading = true
                return .run { send in
                    let reptiles: ReptilesModel = mockReptiles
                    await send(.reptilesResponse(reptiles))
                }
                
            case let .reptilesResponse(reptiles):
                state.isLoading = false
                state.reptiles = reptiles
                return .none
                
            case .didTappedReptileCard:
                return .none
            }
        }
    }
}
