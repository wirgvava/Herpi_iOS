//
//  GalleryPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct GalleryPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var gallery: [Gallery]
        var selectedIndex: Int
        var photos: IdentifiedArrayOf<PhotoFeature.State> = []
        
        var isZooming: Bool {
            photos.contains { $0.isZoomed }
        }
        
        var currentPhoto: Gallery {
            gallery[selectedIndex]
        }
        
        init(gallery: [Gallery], selectedIndex: Int) {
            self.gallery = gallery
            self.selectedIndex = selectedIndex
            self.photos = IdentifiedArray(
                uniqueElements: gallery.map { PhotoFeature.State(id: $0.id, url: $0.url) }
            )
        }
    }
    
    // MARK: - Action
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case selectedIndexChanged
        case photos(IdentifiedActionOf<PhotoFeature>)
    }
    
    // MARK: - Body
    var body: some Reducer<State, Action> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .selectedIndexChanged:
                for id in state.photos.ids {
                    state.photos[id: id]?.scale = 1.0
                    state.photos[id: id]?.lastScale = 1.0
                    state.photos[id: id]?.offset = .zero
                    state.photos[id: id]?.lastOffset = .zero
                }
                return .none
                
            case .photos:
                return .none
            }
        }
        .forEach(\.photos, action: \.photos) {
            PhotoFeature()
        }
    }
}
