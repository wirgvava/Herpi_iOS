//
//  MapPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiModels
import HerpiFoundation
import ComposableArchitecture

@Reducer
struct MapPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var coverage: CoverageModel
        var typeOfPage: TypeOfPage = .map
        
        enum TypeOfPage: Equatable {
            case map
            case detail
        }
    }
    
    // MARK: - Action
    enum Action {
        case dismiss
    }
    
    // MARK: - Dependencies
    @Dependency(\.dismiss) var dismiss
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .run { _ in
                    await HapticsManager.light.vibrate()
                    await dismiss()
                }
            }
        }
    }
}
