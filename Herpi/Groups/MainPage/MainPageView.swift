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
        VStack {
            Header(
                menuAction: { store.send(.menuButtonTapped) },
                pickLocationAction: { store.send(.pickLocationTapped) },
                chatAction: { store.send(.chatButtonTapped) }
            )
            
            ScrollView {
                HStack {
                    Spacer()
                }
            }
            .background(HerpiColor.background)
            .topCornerRadius(Constants.scrollViewCornerRadius)
            .ignoresSafeArea()
        }
        .background(HerpiColor.tint)
    }
    
    struct Constants {
        static let scrollViewCornerRadius: CGFloat = 32
    }
}

#Preview {
    MainPageView(store: .init(initialState: MainPageView.Feature.State(), reducer: {
        MainPageView.Feature()
    }))
}
