//
//  NavigationDestinationView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Path Reducer
extension NavigationFeature {
    @Reducer
    enum Path {
        case search(SearchPageFeature)
        case reptileDetail(DetailPageFeature)
        case map(MapPageFeature)
    }
}

// MARK: - Destination View
struct NavigationDestinationView: View {
    let store: StoreOf<NavigationFeature.Path>

    var body: some View {
        switch store.case {
        case .search(let searchStore):
            SearchPageView(store: searchStore)
            
        case .reptileDetail(let detailStore):
            DetailPageView(store: detailStore)
            
        case .map(let mapStore):
            MapPageView(store: mapStore)
        }
    }
}

// MARK: - Path State Equatable Conformance
extension NavigationFeature.Path.State: Equatable {}
