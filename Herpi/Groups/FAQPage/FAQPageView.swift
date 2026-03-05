//
//  FAQPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 13.02.26.
//

import SwiftUI
import HerpiUI
import ComposableArchitecture

struct FAQPageView: View {
    
    let store: StoreOf<FAQPageFeature>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                Text(L.Menu.faq)
                    .font(HerpiFont.bold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                ForEach(store.faq) { faq in
                    FAQCard(faq: faq)
                        .skeleton(isLoading: store.isLoading)
                }
            }
            .padding(.vertical, Constants.vstackSpacing)
            .padding(.horizontal, Constants.horizontalPadding)
            .onAppear {
                store.send(.fetchFAQ)
            }
        }
        .background(HerpiColor.background)
        .topCornerRadius(Constants.scrollViewCornerRadius)
        .ignoresSafeArea()
    }
    
    struct Constants {
        static let vstackSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 20
        static let scrollViewCornerRadius: CGFloat = 32
    }
}
