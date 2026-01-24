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
        @ObservableState
        struct State: Equatable {
            var isMenuOpen: Bool = false
            var locationPickerSheetShown: Bool = false
            var categories: CategoriesModel = mockCategories
            var selectedCategoryId: String = mockCategories.first?.id ?? .empty
            var nearbyReptiles = NearbyReptilesFeature.State()
        }
        
        enum Action: BindableAction {
            case binding(BindingAction<State>)
            case menuButtonTapped
            case pickLocationTapped
            case chatButtonTapped
            case searchTapped
            case categorySelected(String)
            case nearbyReptiles(NearbyReptilesFeature.Action)
        }
        
        @Dependency(\.openURL) var openURL
        
        var body: some Reducer<State, Action> {
            BindingReducer()
            
            Reduce { state, action in
                switch action {
                case .binding:
                    return .none
                    
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
                    
                case let .categorySelected(categoryId):
                    state.selectedCategoryId = categoryId
                    // TODO: Filter reptiles based on selected category
                    return .none
                    
                case .nearbyReptiles:
                    return .none
                }
            }
            
            Scope(
                state: \.nearbyReptiles,
                action: \.nearbyReptiles
            ) {
                NearbyReptilesFeature()
            }
        }
    }
}
