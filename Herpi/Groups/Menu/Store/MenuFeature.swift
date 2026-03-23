//
//  MenuFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 01.02.26.
//

import SwiftUI
import HerpiFoundation
import ComposableArchitecture

@Reducer
struct MenuFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var menuState: MenuStates = .main
    }
    
    // MARK: - Action
    enum Action {
        case didChangeMenuState(MenuStates)
        case didSwitchedLanguage(Int)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .didChangeMenuState(let menuState):
                state.menuState = menuState
                
                return .run { _ in
                    await HapticsManager.selection.vibrate()
                }
                
            case .didSwitchedLanguage(let selectedIndex):
                return .run { _ in
                    AppLanguage.setLanguage(selectedIndex == .zero ? .ka : .en)
                }
            }
        }
    }
}
