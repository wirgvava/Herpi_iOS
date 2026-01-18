//
//  MainPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import ComposableArchitecture

extension MainPageView {
    @Reducer
    struct Feature {
        @ObservableState
        struct State: Equatable {
            var isMenuOpen: Bool = false
            var locationPickerSheetShown: Bool = false
        }
        
        enum Action {
            case menuButtonTapped
            case pickLocationTapped
            case chatButtonTapped
        }
        
        var body: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                case .menuButtonTapped:
                    state.isMenuOpen.toggle()
                    return .none
                    
                case .pickLocationTapped:
                    state.locationPickerSheetShown.toggle()
                    return .none
                    
                case .chatButtonTapped:
                    return .run { _ in
                        if let url = URL(string: AppConstants.chatUrl) {
                            AppAnalytics.logEvents(with: .click_chat)
                            
                            Task {
                                await MainActor.run {
                                    UIApplication.shared.open(url)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
