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
            VStack {
                Header(
                    menuAction: { store.send(.menuButtonTapped) },
                    pickLocationAction: { store.send(.pickLocationTapped) },
                    chatAction: { store.send(.chatButtonTapped) }
                )
                
                ScrollView {
                    SearchBar(
                        viewType: .button,
                        placeholder: L.SearchBar.placeholder
                    )
                    .onTapGesture { store.send(.searchTapped) }
                    
                    CategoriesView(
                        selectedCategoryId: store.selectedCategoryId,
                        categories: store.categories,
                        onCategorySelected: { categoryId in
                            store.send(.categorySelected(categoryId))
                        }
                    )
                    
                    NearbyReptilesView(
                        store: store.scope(
                            state: \.nearbyReptiles,
                            action: \.nearbyReptiles
                        )
                    )
                }
                .padding(.horizontal, Constants.scrollViewHorizontalPadding)
                .background(HerpiColor.background)
                .topCornerRadius(Constants.scrollViewCornerRadius)
                .ignoresSafeArea()
            }
            .background(HerpiColor.tint)
        }
    }
    
    struct Constants {
        static let scrollViewCornerRadius: CGFloat = 32
        static let scrollViewHorizontalPadding: CGFloat = 30
    }
}

#Preview {
    MainPageView(store: .init(initialState: MainPageView.Feature.State(), reducer: {
        MainPageView.Feature()
    }))
}
