//
//  PhotoFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct PhotoFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: Int
        let url: String
        var scale: CGFloat = 1.0
        var lastScale: CGFloat = 1.0
        var offset: CGSize = .zero
        var lastOffset: CGSize = .zero
        
        var isZoomed: Bool {
            scale > 1.0
        }
        
        init(id: Int, url: String) {
            self.id = id
            self.url = url
        }
    }
    
    // MARK: - Action
    enum Action {
        case magnificationChanged(CGFloat)
        case magnificationEnded
        case dragChanged(CGSize)
        case dragEnded
        case doubleTapped
        case resetZoom
    }
    
    // MARK: - Constants
    private enum Constants {
        static let maxZoom: CGFloat = 4.0
        static let doubleTapZoom: CGFloat = 2.5
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .magnificationChanged(let value):
                let delta = value / state.lastScale
                state.lastScale = value
                state.scale = min(max(state.scale * delta, 1.0), Constants.maxZoom)
                return .none
                
            case .magnificationEnded:
                state.lastScale = 1.0
                if state.scale <= 1.0 {
                    state.scale = 1.0
                    state.offset = .zero
                    state.lastOffset = .zero
                }
                return .none
                
            case .dragChanged(let translation):
                state.offset = CGSize(
                    width: state.lastOffset.width + translation.width,
                    height: state.lastOffset.height + translation.height
                )
                return .none
                
            case .dragEnded:
                state.lastOffset = state.offset
                return .none
                
            case .doubleTapped:
                if state.scale > 1.0 {
                    state.scale = 1.0
                    state.offset = .zero
                    state.lastOffset = .zero
                } else {
                    state.scale = Constants.doubleTapZoom
                }
                return .none
                
            case .resetZoom:
                state.scale = 1.0
                state.lastScale = 1.0
                state.offset = .zero
                state.lastOffset = .zero
                return .none
            }
        }
    }
}
