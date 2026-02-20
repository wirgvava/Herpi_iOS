//
//  DistributionArea.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 20.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import MapKit

extension DetailPageView {
    struct DistributionArea: View {
        let coverage: CoverageModel
        var expandMap: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                Text(L.DetailPage.distributionAreas)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                ZStack(alignment: .bottom) {
                    DistributionMapView(
                        region: Constants.region,
                        coverage: coverage
                    )
                    .frame(height: Constants.mapHeight)
                    .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                    
                    RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                        .fill(HerpiColor.tint)
                        .frame(height: Constants.buttonHeight)
                        .shadow(radius: Constants.buttonShadowRadius)
                        .padding()
                        .overlay {
                            Text(L.DetailPage.openMapButton)
                                .font(HerpiFont.semibold_16)
                                .foregroundStyle(HerpiColor.white)
                        }
                        .onTapGesture { expandMap() }
                }
            }
        }
        
        struct Constants {
            static let vstackSpacing: CGFloat = 12
            static let mapHeight: CGFloat = 326
            static let cornerRadius: CGFloat = 24
            static let buttonCornerRadius: CGFloat = 23
            static let buttonHeight: CGFloat = 46
            static let buttonShadowRadius: CGFloat = 8
            static let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 42.054490, longitude: 43.728376),
                span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)
            )
        }
    }
}
