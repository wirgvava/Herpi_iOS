//
//  ReptilesListView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 25.01.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

struct ReptilesListView: View {
    
    let store: StoreOf<ReptilesListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: Constants.spacing) {
                SectionHeader(
                    header: store.selectedCategory,
                    description: L.MainPage.ReptilesList.headerDescription
                )
                
                ForEach(store.reptiles) { reptile in
                    WithPerceptionTracking {
                        ReptilesListCard(
                            reptile: reptile,
                            isLoading: store.isLoading
                        )
                        .onTapGesture {
                            store.send(.didTappedReptileCard(reptile.id))
                        }
                    }
                }
            }
            .onAppear {
                store.send(.fetchReptiles)
            }
        }
    }
    
    struct Constants {
        static let spacing: CGFloat = 16
    }
}
