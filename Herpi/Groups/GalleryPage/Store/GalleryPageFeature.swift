//
//  GalleryPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct GalleryPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var gallery: [Gallery]
        var selectedIndex: Int
        var isZooming: Bool = false
    }
    
    // MARK: - Action
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case disableZooming
    }
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .disableZooming:
                state.isZooming = false
                return .none
            }
        }
    }
}
