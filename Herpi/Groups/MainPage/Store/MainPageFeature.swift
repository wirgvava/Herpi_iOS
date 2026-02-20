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

            var nearbyReptiles = NearbyReptilesFeature.State()

            var reptiles = ReptilesListFeature.State(
                selectedCategory: mockCategories.first?.titleTurned ?? .empty
            )
        }

        // MARK: - Action
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            case push(NavigationFeature.Path.State)

            case searchTapped
            case categorySelected(String)

            case nearbyReptiles(NearbyReptilesFeature.Action)
            case reptilesList(ReptilesListFeature.Action)
        }

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
