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
        var faq: FAQModel = []
        var isLoading: Bool = false
    }
    
    // MARK: - Action
    enum Action {
        case fetchFAQ
        case didReceivedResponse(FAQModel)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchFAQ:
                state.isLoading = true
                return .run { send in
                    let faq: FAQModel = mockFAQModel
                    await send(.didReceivedResponse(faq))
                }
                
            case .didReceivedResponse(let faq):
                state.isLoading = false
                state.faq = faq
                return .none
            }
        }
    }
}
