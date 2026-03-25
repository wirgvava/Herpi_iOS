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
    
    @Bindable var store: StoreOf<Feature>
    
    var body: some View {
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
                    },
                    onScrollingChanged: { isScrolling in
                        store.send(.setCategoriesScrolling(isScrolling))
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
        .onAppear {
            store.send(.onAppear)
        }
        .sheet(isPresented: $store.location.isPickLocationSheetPresented, onDismiss: {
            store.send(.location(.setPickLocationSheetPresented(false)))
        }) {
            ChooseLocationSheet(
                store: .init(
                    initialState: ChooseLocationFeature.State(
                        latitude: store.location.latitude,
                        longitude: store.location.longitude,
                        currentLocationString: store.location.currentLocationString
                    ),
                    reducer: { ChooseLocationFeature() }
                ),
                completeAction: { latitude, longitude in
                    store.send(.location(.locationUpdated(latitude: latitude, longitude: longitude)))
                }
            )
        }
        .sheet(isPresented: $store.location.isDisabledLocationAlertPresented, onDismiss: {
            store.send(.location(.setDisabledLocationAlertPresented(false)))
        }) {
            DisabledLocationAlert(
                openSettingsAction: {
                    store.send(.location(.openSystemSettings))
                }
            )
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
