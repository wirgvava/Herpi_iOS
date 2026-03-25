//
//  NearbyReptilesView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import HerpiFoundation
import ComposableArchitecture

struct NearbyReptilesView: View {
    
    let store: StoreOf<NearbyReptilesFeature>
    
    var body: some View {
        VStack(spacing: .zero) {
            if store.reptiles.isEmpty {
                EmptyNearbyReptilesView()
                    .skeleton(isLoading: store.isLoading)
            } else {
                SectionHeader(
                    header: L.MainPage.NearbyReptiles.header,
                    description: L.MainPage.NearbyReptiles.description
                )
                
                NearbyReptilesCollection(
                    reptiles: store.reptiles,
                    currentPage: store.currentPage,
                    isLoading: store.isLoading,
                    pageChanged: { page in
                        store.send(.pageChanged(page))
                    }, cardTapped: { id in
                        store.send(.didTappedReptileCard(id))
                    }, onScrollingChanged: { isScrolling in
                        store.send(.setIsScrollingHorizontally(isScrolling))
                    }
                )
                .padding(.top, Constants.collectionTopPadding)
            }
        }
    }
    
    struct Constants {
        static let collectionTopPadding: CGFloat = 16
    }
}

#Preview {
    NearbyReptilesView(
        store: .init(initialState: NearbyReptilesFeature.State()) {
            NearbyReptilesFeature()
        }
    )
}
