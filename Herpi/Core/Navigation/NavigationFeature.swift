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
            case .path(.element(_, let childAction)):
                // Centralized navigation handling for all child pages
                if let destination = extractDestination(from: childAction) {
                    state.path.append(destination)
                }
                return .none
                
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
    
    // MARK: - Destination Extraction
    /// Add new cases here when adding pages that can navigate
    private func extractDestination(from action: Path.Action) -> Path.State? {
        switch action {
        case .reptileDetail(.push(let destination)): destination
        case .search(.push(let destination)): destination
        default: nil
        }
    }
}
