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
    
    @Bindable var store: StoreOf<GalleryPageFeature>
    var dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            background
            photoPager
            navBarWithFooter
        }
    }
    
    // MARK: - Background
    private var background: some View {
        Color.black.opacity(Constants.bgOpacity)
            .ignoresSafeArea()
    }
    
    // MARK: - Photo Pager
    private var photoPager: some View {
        TabView(selection: $store.selectedIndex) {
            ForEach(store.gallery.indices, id: \.self) { index in
                PhotoPageItem(
                    store: store,
                    index: index,
                    photoId: store.gallery[index].id
                )
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .onChange(of: store.selectedIndex) { _, _ in
            store.send(.selectedIndexChanged)
        }
    }
    
    // MARK: - NavBar With Footer
    private var navBarWithFooter: some View {
        NavBarWithFooter(
            navBarTitle: "\(store.selectedIndex + .one) / \(store.gallery.count)",
            credits: L.DetailPage.creditsTo(store.currentPhoto.author.fullName),
            isZooming: store.isZooming,
            dismissAction: { dismissAction() }
        )
        .padding(.horizontal, Constants.horizontalPadding)
    }
    
    struct Constants {
        static let bgOpacity: Double = 0.8
        static let backButtonWidth: CGFloat = 25
        static let horizontalPadding: CGFloat = 16
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
