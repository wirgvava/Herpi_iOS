//
//  SearchPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 17.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct SearchPageFeature {

    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var results: SearchResponseModel = .init(data: [])
        var searchText: String = .empty
        var isLoading: Bool = false
    }

    // MARK: - Action
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case search(query: String)
        case didReceivedResponse(SearchResponseModel)
        case didTappedOnCard(id: Int)

        case push(NavigationFeature.Path.State)
    }

    // MARK: - Cancel ID
    private enum CancelID {
        case search
    }

    // MARK: - Reducer
    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.searchText):
                let query = state.searchText

                guard !query.isEmpty else {
                    state.results = .init(data: [])
                    state.isLoading = false
                    return .cancel(id: CancelID.search)
                }

                return .run { send in
                    try await Task.sleep(for: .milliseconds(500))
                    await send(.search(query: query))
                }
                .cancellable(id: CancelID.search, cancelInFlight: true)

            case .binding:
                return .none

            case .push:
                return .none

                // MARK: API Actions
            case .search(query: _):
                state.isLoading = true
                return .run { send in
                    // TODO: Replace with actual API call
                    let response = SearchResponseModel(data: mockSearchedData)
                    await send(.didReceivedResponse(response))
                }

            case .didReceivedResponse(let response):
                state.isLoading = false
                state.results = response
                return .none

                // MARK: UI Actions
            case .didTappedOnCard(let id):
                return .send(.push(.reptileDetail(DetailPageFeature.State(reptileId: id))))
            }
        }
    }
}
