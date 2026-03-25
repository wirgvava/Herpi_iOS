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
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var allReptiles: ReptilesModel = []
        var reptiles: ReptilesModel = mockReptiles /// default data for skeleton animation.
        var selectedCategory: String = .empty
        var isLoading: Bool = false
    }
    
    // MARK: - Action
    enum Action: Equatable {
        case fetchReptiles
        case reptilesResponse(ReptilesModel)
        case didFailWithError(String)
        case didTappedReptileCard(Int)
        case categoryChanged(id: String, name: String)
    }
    
    // MARK: - Dependencies
    @Dependency(\.apiClient) var apiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchReptiles:
                state.isLoading = true
                
                return .run { send in
                    let reptiles = try await apiClient.fetchReptiles()
                    await send(.reptilesResponse(reptiles))
                } catch: { error, send in
                    await send(.didFailWithError(error.localizedDescription))
                }
                
            case let .reptilesResponse(reptiles):
                state.isLoading = false
                state.allReptiles = reptiles
                state.reptiles = reptiles
                return .none
                
            case .categoryChanged(let id, let name):
                state.selectedCategory = name

                if state.allReptiles.filter({ $0.type == id }).isEmpty {
                    state.reptiles = state.allReptiles
                } else {
                    state.reptiles = state.allReptiles.filter { $0.type == id }
                }
                
                return .none
                
            case .didTappedReptileCard, .didFailWithError:
                return .none
            }
        }
    }
}
