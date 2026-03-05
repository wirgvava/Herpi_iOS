//
//  PhotoPageItem.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 05.03.26.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Photo Page Item
struct PhotoPageItem: View {
    let store: StoreOf<GalleryPageFeature>
    let index: Int
    let photoId: Int
    
    var body: some View {
        IfLetStore(
            store.scope(
                state: \.photos[id: photoId],
                action: \.photos[id: photoId]
            )
        ) { photoStore in
            PhotoView(store: photoStore)
                .tag(index)
        }
    }
}
