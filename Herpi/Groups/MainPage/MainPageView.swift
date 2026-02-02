//
//  MainPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.06.25.
//

import SwiftUI
import HerpiUI
import HerpiFoundation
import ComposableArchitecture

struct MainPageView: View {
    
    let store: StoreOf<Feature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: Constants.viewPadding) {
                    SearchBar(
                        viewType: .button,
                        placeholder: L.SearchBar.placeholder
                    )
                    .onTapGesture { store.send(.searchTapped) }
                    
                    CategoriesView(
                        selectedCategory: store.selectedCategory,
                        categories: store.categories,
                        onCategorySelected: { category in
                            store.send(.categorySelected(category))
                        }
                    )
                    
                    NearbyReptilesView(
                        store: store.scope(
                            state: \.nearbyReptiles,
                            action: \.nearbyReptiles
                        )
                    )
                    
                    ReptilesListView(
                        store: store.scope(
                            state: \.reptiles,
                            action: \.reptilesList
                        )
                    )
                }
                .padding(Constants.viewPadding)
            }
            .background(HerpiColor.background)
            .topCornerRadius(Constants.scrollViewCornerRadius)
            .ignoresSafeArea()
        }
    }
    
    struct Constants {
        static let scrollViewCornerRadius: CGFloat = 32
        static let viewPadding: CGFloat = 30
    }
}

#Preview {
    MainPageView(store: .init(initialState: MainPageView.Feature.State(), reducer: {
        MainPageView.Feature()
    }))
}
