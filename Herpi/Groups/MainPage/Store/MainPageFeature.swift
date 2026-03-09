//
//  MainPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

extension MainPageView {
    @Reducer
    struct Feature {

        // MARK: - State
        @ObservableState
        struct State: Equatable {
            var categories: CategoriesModel = mockCategories
            var selectedCategory: String = mockCategories.first?.titleTurned ?? .empty
            
            var location = LocationFeature.State()
            var nearbyReptiles = NearbyReptilesFeature.State()
            var reptiles = ReptilesListFeature.State(
                selectedCategory: mockCategories.first?.titleTurned ?? .empty
            )
        }

        // MARK: - Action
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            case push(NavigationFeature.Path.State)
            case didFailWithError(String)

            case searchTapped
            case categorySelected(String)

            case location(LocationFeature.Action)
            case nearbyReptiles(NearbyReptilesFeature.Action)
            case reptilesList(ReptilesListFeature.Action)
        }

        var body: some Reducer<State, Action> {
            BindingReducer()

            Scope(state: \.location, action: \.location) {
                LocationFeature()
            }
            
            Scope(state: \.nearbyReptiles, action: \.nearbyReptiles) {
                NearbyReptilesFeature()
            }

            Scope(state: \.reptiles, action: \.reptilesList) {
                ReptilesListFeature()
            }

            Reduce { state, action in
                switch action {
                case .binding, .push, .didFailWithError:
                    return .none

                case .searchTapped:
                    return .send(.push(.search(SearchPageFeature.State())))

                case .categorySelected(let category):
                    state.selectedCategory = category
                    state.reptiles.selectedCategory = category
                    return .none

                // MARK: Child feature actions
                case .nearbyReptiles(.didTappedReptileCard(let id)):
                    return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))

                case .reptilesList(.didTappedReptileCard(let id)):
                    return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))

                case .location, .nearbyReptiles, .reptilesList:
                    return .none
                }
            }
        }
    }
}
