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
                        .skeleton(isLoading: store.isLoading)
                    
                    VStack(spacing: Constants.vstackSpacing) {
                        InfoCard(
                            info: store.detailedInfo,
                            isLoading: store.isLoading
                        )
                            
                        Description(
                            info: store.detailedInfo,
                            isLoading: store.isLoading
                        )
                        
                        Gallery(
                            info: store.detailedInfo,
                            isLoading: store.isLoading,
                            tapped: { id in
                                store.send(.didTapOnPhoto(id))
                            }
                        )
                        
                        DistributionArea(
                            coverage: store.coverage,
                            isLoading: store.isLoading,
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
                
                /// Gallery
                if store.showGallery {
                    GalleryPageView(
                        store: .init(
                            initialState: GalleryPageFeature.State(
                                gallery: store.detailedInfo.gallery,
                                selectedIndex: store.selectedPhotoIndex
                            ),
                            reducer: { GalleryPageFeature() }
                        ),
                        dismissAction: {
                            store.send(.dismissGallery)
                        }
                    )
                }
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
