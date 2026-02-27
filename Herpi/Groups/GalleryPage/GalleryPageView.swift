//
//  GalleryPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import ComposableArchitecture

struct GalleryPageView: View {
    
    @Perception.Bindable var store: StoreOf<GalleryPageFeature>
    var dismissAction: () -> Void
    
    var body: some View {
        WithPerceptionTracking {
            ZStack {
                /// Background
                Color.black.opacity(Constants.bgOpacity)
                    .ignoresSafeArea()
                
                /// Photo Pager
                TabView(selection: $store.selectedIndex) {
                    ForEach(Array(store.gallery.enumerated()), id: \.element.id) { index, photo in
                        PhotoView(url: photo.url, isZooming: $store.isZooming)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .onChange(of: store.selectedIndex) { _ in
                    store.send(.disableZooming)
                }
                
                /// NavBar & Footer
                NavBarWithFooter(
                    navBarTitle: "\(store.selectedIndex + .one) / \(store.gallery.count)",
                    credits: L.DetailPage.creditsTo(
                        store.gallery[store.selectedIndex].author.fullName
                    ),
                    isZooming: store.isZooming,
                    dismissAction: { dismissAction() }
                )
                .padding(.horizontal, Constants.horizontalPadding)
            }
        }
    }
    
    struct Constants {
        static let bgOpacity: Double = 0.8
        static let backButtonWidth: CGFloat = 25
        static let horizontalPadding: CGFloat = 30
    }
}

#Preview {
    GalleryPageView(
        store: .init(
            initialState: GalleryPageFeature.State(
                gallery: [
                    mockGallery_1, mockGallery_2,
                    mockGallery_3, mockGallery_4, mockGallery_5
                ],
                selectedIndex: .zero
            ),
            reducer: { GalleryPageFeature() }
        ),
        dismissAction: { }
    )
}
