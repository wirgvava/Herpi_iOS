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
            var isMenuOpen: Bool = false
            var locationPickerSheetShown: Bool = false
            
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
            
            case menuButtonTapped
            case pickLocationTapped
            case chatButtonTapped
            case searchTapped
            case categorySelected(String)
            
            case nearbyReptiles(NearbyReptilesFeature.Action)
            case reptilesList(ReptilesListFeature.Action)
        }
        
        // MARK: - Dependencies
        @Dependency(\.openURL) var openURL
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            
            Reduce { state, action in
                switch action {
                case .binding:
                    return .none
                  
                // MARK: UI Actions
                case .menuButtonTapped:
                    state.isMenuOpen.toggle()
                    return .none
                    
                case .pickLocationTapped:
                    state.locationPickerSheetShown.toggle()
                    return .none
                    
                case .chatButtonTapped:
                    AppAnalytics.logEvents(with: .click_chat)
                    
                    return .run { _ in
                        if let url = URL(string: AppConstants.chatUrl) {
                            await openURL(url)
                        }
                    }
                    
                case .searchTapped:
                    print("Navigate to search page")
                    return .none
                    
                case .categorySelected(let category):
                    state.selectedCategory = category
                    state.reptiles.selectedCategory = category
                    return .none
                    
                // MARK: Child features
                case .nearbyReptiles(.didTappedReptileCard(let id)):
                    print("Navigate to Reptile Detailed page for \(id)")
                    return .none
                    
                case .nearbyReptiles:
                    return .none
                    
                case .reptilesList(.didTappedReptileCard(let id)):
                    print("Navigate to Reptile Detailed page for \(id)")
                    return .none
                    
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
