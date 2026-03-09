//
//  FAQPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 13.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct FAQPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var faq: FAQModel = mockFAQModel /// default data for skeleton animation
        var isLoading: Bool = false
    }
    
    // MARK: - Action
    enum Action {
        case fetchFAQ
        case didReceivedResponse(FAQModel)
        case didFailWithError(String)
    }
    
    // MARK: - Dependencies
    @Dependency(\.apiClient) var apiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchFAQ:
                state.isLoading = true
                
                return .run { send in
                    let faq = try await apiClient.fetchFAQ()
                    await send(.didReceivedResponse(faq))
                } catch: { error, send in
                    await send(.didFailWithError(error.localizedDescription))
                }
                
            case .didReceivedResponse(let faq):
                state.isLoading = false
                state.faq = faq
                return .none
                
            case .didFailWithError:
                return .none
            }
        }
    }
}
