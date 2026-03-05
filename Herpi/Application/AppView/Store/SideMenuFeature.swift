//
//  SideMenuFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct SideMenuFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var width: CGFloat = 330
        var dimmingOverlayOpacity: Double = 0.6
        var offset: CGFloat = .zero
        var lastDragOffset: CGFloat = .zero
        var dragProgress: CGFloat = .zero
        var isHorizontalDrag: Bool = false
        
        var isOpen: Bool {
            offset > .zero
        }
    }
    
    // MARK: - Action
    enum Action {
        case open
        case close
        case toggle
        case dragChanged(DragGesture.Value)
        case dragEnded(DragGesture.Value)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .open:
                withAnimation(.snappy(duration: 0.25, extraBounce: .zero)) {
                    state.offset = state.width
                    state.dragProgress = state.offset / state.width
                    state.lastDragOffset = state.offset
                }
                return .none
                
            case .close:
                withAnimation(.snappy(duration: 0.25, extraBounce: .zero)) {
                    state.offset = .zero
                    state.dragProgress = .zero
                }
                state.lastDragOffset = .zero
                return .none
                
            case .toggle:
                if state.isOpen {
                    return .send(.close)
                } else {
                    return .send(.open)
                }
                
            case .dragChanged(let value):
                if !state.isHorizontalDrag {
                    let h = abs(value.translation.width)
                    let v = abs(value.translation.height)
                    
                    if h > 50 && h > v * 1.5 {
                        state.isHorizontalDrag = true
                    } else {
                        return .none
                    }
                }
                
                let translation = value.translation.width + state.lastDragOffset
                let clamped = max(min(translation, state.width), .zero)
                
                state.offset = clamped
                state.dragProgress = clamped / state.width
                return .none
                
            case .dragEnded(let value):
                state.isHorizontalDrag = false
                let velocity = value.translation.width / 3
                
                if (velocity + state.offset) > state.width * 0.3 {
                    state.offset = state.width
                } else {
                    state.offset = .zero
                }
                
                state.dragProgress = state.offset / state.width
                state.lastDragOffset = state.offset
                return .none
            }
        }
    }
}
