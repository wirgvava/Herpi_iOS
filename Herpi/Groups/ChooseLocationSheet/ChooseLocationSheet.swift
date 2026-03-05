//
//  ChooseLocationSheet.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 28.02.26.
//

import SwiftUI
import HerpiUI
import ComposableArchitecture

struct ChooseLocationSheet: View {
    
    @Bindable var store: StoreOf<ChooseLocationFeature>
    @Environment(\.presentationMode) private var presentationMode
    var completeAction: (Double, Double) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            let availableHeight = geometry.size.height
            let mapHeight = max(Constants.mapMinHeight, availableHeight - Constants.fixedContentHeight)
            
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(spacing: Constants.vstackSpacing) {
                    Header()
                    
                    MapView(
                        latitude: store.latitude,
                        longitude: store.longitude,
                        annotationCoordinate: store.annotationCoordinate,
                        onTap: { coordinate in
                            store.send(.mapTapped(coordinate))
                        }
                    )
                    .frame(height: mapHeight)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.mapCornerRadius))
                    
                    Footer(
                        currentLocationString: store.currentLocationString,
                        cancelAction: {
                            presentationMode.wrappedValue.dismiss()
                        },
                        completeAction: {
                            completeAction(store.latitude, store.longitude)
                            presentationMode.wrappedValue.dismiss()
                        }
                    )
                }
                .padding(Constants.padding)
            }
        }
        .presentationDetents([.medium, .large], selection: $store.selectedDetent)
        .presentationDragIndicator(.visible)
    }
    
    struct Constants {
        static let mapMinHeight: CGFloat = 150
        static let fixedContentHeight: CGFloat = 240
        static let vstackSpacing: CGFloat = 20
        static let mapCornerRadius: CGFloat = 16
        static let padding: CGFloat = 20
    }
}
