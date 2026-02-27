//
//  MapPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import MapKit
import ComposableArchitecture

struct MapPageView: View {
    
    let store: StoreOf<MapPageFeature>
    var onButtonTap: (() -> Void)?
    
    var body: some View {
        WithPerceptionTracking {
            ZStack(alignment: .bottom) {
                DistributionMapView(
                    region: Constants.region,
                    coverage: store.coverage
                )
                .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                    .fill(HerpiColor.tint)
                    .frame(height: Constants.buttonHeight)
                    .shadow(radius: Constants.buttonShadowRadius)
                    .padding()
                    .overlay {
                        Text(store.typeOfPage == .detail ? L.DetailPage.openMapButton : L.Common.back)
                            .font(HerpiFont.semibold_16)
                            .foregroundStyle(HerpiColor.white)
                    }
                    .onTapGesture {
                        if let onButtonTap {
                            onButtonTap()
                        } else {
                            store.send(.dismiss)
                        }
                    }
            }
        }
    }
    
    struct Constants {
        static let buttonCornerRadius: CGFloat = 23
        static let buttonHeight: CGFloat = 46
        static let buttonShadowRadius: CGFloat = 8
        static let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 42.054490, longitude: 43.728376),
            span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
        )
    }
}

#Preview {
    MapPageView(
        store: .init(
            initialState: MapPageFeature.State(coverage: mockCoverage),
            reducer: { MapPageFeature() }
        )
    )
}
