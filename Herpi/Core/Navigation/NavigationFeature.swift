//
//  NavigationFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct NavigationFeature {

    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var path: StackState<Path.State> = StackState()
    }

    // MARK: - Action
    enum Action {
        case path(StackActionOf<Path>)
        case push(Path.State)
        case popToRoot
        case pop
    }

    // MARK: - Body
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .path:
                return .none

            case .push(let destination):
                state.path.append(destination)
                return .none

            case .popToRoot:
                state.path.removeAll()
                return .none

            case .pop:
                _ = state.path.popLast()
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
