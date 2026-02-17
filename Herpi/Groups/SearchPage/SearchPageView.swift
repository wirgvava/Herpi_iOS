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
    
    @Perception.Bindable var store: StoreOf<SearchPageFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack {
                searchBar
                searchResults
            }
            .background(HerpiColor.tint)
        }
    }
    
    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: Constants.searchBarSpacing) {
            BackButton()
            SearchBar(placeholder: L.SearchBar.placeholder, searchText: $store.searchText)
        }
        .padding(.vertical, Constants.searchBarVerticalPadding)
        .padding(.horizontal, Constants.searchBarHorizontalPadding)
    }
    
    // MARK: - Search Results
    private var searchResults: some View {
        ScrollView {
            VStack(alignment: .leading) {
                resultsHeader
                resultsList
            }
            .padding(.horizontal, Constants.resultsHorizontalPadding)
        }
        .background(HerpiColor.background)
        .topCornerRadius(Constants.resultsViewCornerRadius)
        .ignoresSafeArea()
    }
    
    private var resultsHeader: some View {
        HStack {
            Text(L.SearchBar.results)
                .font(HerpiFont.bold_16)
                .foregroundStyle(HerpiColor.Title.primary)
                .frame(height: Constants.resultsHeaderHeight)
            
            Spacer()
        }
    }
    
    private var resultsList: some View {
        ForEach(store.isLoading ? mockSearchedData : store.results.data ?? []) { reptile in
            SearchResultCard(reptile: reptile)
                .skeleton(isLoading: store.isLoading)
                .onTapGesture {
                    store.send(.didTappedOnCard(id: reptile.id))
                }
        }
    }
    
    // MARK: - Constants
    struct Constants {
        static let searchBarSpacing: CGFloat = 25
        static let searchBarVerticalPadding: CGFloat = 35
        static let searchBarHorizontalPadding: CGFloat = 30
        static let resultsHeaderHeight: CGFloat = 60
        static let resultsHorizontalPadding: CGFloat = 30
        static let resultsViewCornerRadius: CGFloat = 32
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
