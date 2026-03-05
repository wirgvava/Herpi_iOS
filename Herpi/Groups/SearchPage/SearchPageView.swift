//
//  SearchPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 17.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import ComposableArchitecture

struct SearchPageView: View {
    
    @Bindable var store: StoreOf<SearchPageFeature>
    
    var body: some View {
        VStack {
            SearchPageSearchBar(
                searchText: $store.searchText
            )
            
            SearchResults(
                data: store.results.data ?? [],
                isLoading: store.isLoading,
                didTappedOnCard: { id in
                    store.send(.didTappedOnCard(id: id))
                }
            )
        }
        .background(HerpiColor.tint)
    }
}

#Preview {
    SearchPageView(
        store: .init(
            initialState: SearchPageFeature.State(),
            reducer: { SearchPageFeature() }
        )
    )
}
