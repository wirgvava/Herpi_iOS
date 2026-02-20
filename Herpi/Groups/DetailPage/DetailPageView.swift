//
//  DetailPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import ComposableArchitecture

struct DetailPageView: View {
    
    let store: StoreOf<DetailPageFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                ScrollView {
                    BackgroundImage(url: store.detailedInfo.image.asURL())
                    
                    VStack(spacing: Constants.vstackSpacing) {
                        InfoCard(info: store.detailedInfo)
                        Description(info: store.detailedInfo)
                        Gallery(
                            info: store.detailedInfo,
                            tapped: { id in
                                store.send(.didTapOnPhoto(id))
                            }
                        )
                        DistributionArea(
                            coverage: store.coverage,
                            expandMap: {
                                store.send(.didTapOnExpandMap)
                            }
                        )
                    }
                    .padding(.horizontal, Constants.contentHorizontalPadding)
                    .padding(.bottom, Constants.bottomPadding)
                }
                .background(HerpiColor.background)
                .ignoresSafeArea()
                
                /// Nav bar
                NavBar(
                    shareAction: {
                        store.send(.didTapOnShare)
                    }
                )
                .padding(.horizontal, Constants.contentHorizontalPadding)                
            }
        }
    }
    
    struct Constants {
        static let vstackSpacing: CGFloat = 20
        static let bottomPadding: CGFloat = 80
        static let contentHorizontalPadding: CGFloat = 30
    }
}

#Preview {
    DetailPageView(
        store: .init(
            initialState: DetailPageFeature.State(reptileId: mockDetailedInfo.id),
            reducer: { DetailPageFeature() }
        )
    )
}
