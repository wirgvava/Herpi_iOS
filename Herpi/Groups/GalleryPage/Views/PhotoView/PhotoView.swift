//
//  PhotoView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiUI
import ComposableArchitecture

struct PhotoView: View {
    
    let store: StoreOf<PhotoFeature>
    
    var body: some View {
        GeometryReader { geometry in
            CachedAsyncImage(url: store.url)
                .aspectRatio(contentMode: .fit)
                .scaleEffect(store.scale)
                .offset(store.offset)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            store.send(.magnificationChanged(value))
                        }
                        .onEnded { _ in
                            store.send(.magnificationEnded, animation: .spring())
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: store.isZoomed ? .zero : .infinity)
                        .onChanged { value in
                            store.send(.dragChanged(value.translation))
                        }
                        .onEnded { _ in
                            store.send(.dragEnded)
                        }
                )
                .simultaneousGesture(
                    TapGesture(count: 2)
                        .onEnded {
                            store.send(.doubleTapped, animation: .spring())
                        }
                )
        }
    }
}
