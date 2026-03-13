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
            var categories: CategoriesModel = mockCategories /// default data for skeleton animation
            var selectedCategory: String = .empty
            
            var location = LocationFeature.State()
            var nearbyReptiles = NearbyReptilesFeature.State()
            var reptiles = ReptilesListFeature.State()
        }

        // MARK: - Action
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            case push(NavigationFeature.Path.State)
            case onAppear
            case categoriesReceived(CategoriesModel)
            case didFailWithError(String)

            case searchTapped
            case categorySelected(String)

            case location(LocationFeature.Action)
            case nearbyReptiles(NearbyReptilesFeature.Action)
            case reptilesList(ReptilesListFeature.Action)
        }
        
        // MARK: - Dependencies
        @Dependency(\.apiClient) var apiClient

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
                    
                case .onAppear:
                    return .run { send in
                        let categories = try await apiClient.fetchCategories()
                        await send(.categoriesReceived(categories))
                        await send(.location(.requestPermission))
                    } catch: { error, send in
                        await send(.didFailWithError(error.localizedDescription))
                    }
                    
                case .categoriesReceived(let categories):
                    state.categories = categories
                    state.selectedCategory = categories.first?.titleTurned ?? .empty
                    state.reptiles = ReptilesListFeature.State(selectedCategory: state.selectedCategory)
                    return .none

                case .searchTapped:
                    AppAnalytics.log(AppAnalytics.Navigation.openedSearch)
                    return .send(.push(.search(SearchPageFeature.State())))

                case .categorySelected(let category):
                    state.selectedCategory = category
                    state.reptiles.selectedCategory = category
                    
                    AppAnalytics.log(AppAnalytics.Category.selected(id: category))
                    return .none

                // MARK: Child feature actions
                case .nearbyReptiles(.didTappedReptileCard(let id)):
                    AppAnalytics.log(AppAnalytics.Navigation.openedNearbySpecieDetails(specieId: id))
                    return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))
                    
                case .nearbyReptiles(.didFailWithError(let errorMessage)):
                    return .send(.didFailWithError(errorMessage))

                case .reptilesList(.didTappedReptileCard(let id)):
                    AppAnalytics.log(AppAnalytics.Navigation.openedDetails(specieId: id))
                    return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))
                    
                case .reptilesList(.didFailWithError(let errorMessage)):
                    return .send(.didFailWithError(errorMessage))
                    
                case .location(.locationUpdated(let latitude, let longitude)):
                    state.nearbyReptiles = NearbyReptilesFeature.State(latitude: latitude, longitude: longitude)
                    return .send(.nearbyReptiles(.fetchReptiles))

                case .location, .nearbyReptiles, .reptilesList:
                    return .none
                }
            }
        }
    }
}
