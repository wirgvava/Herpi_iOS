//
//  NearbyReptileCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import Kingfisher

struct NearbyReptileCard: View {
    
    var reptile: NearbyReptileModel
    var isLoading: Bool
    private var venomTypeString: String
    private var venomTypeColor: Color
    
    init(reptile: NearbyReptileModel, isLoading: Bool) {
        self.reptile = reptile
        self.isLoading = isLoading
        
        if reptile.hasMildVenom {
            venomTypeColor = HerpiColor.VenomType.midVenomous
            venomTypeString = L.VenomType.midVenomous
        } else if reptile.venomous {
            venomTypeColor = HerpiColor.VenomType.venomous
            venomTypeString = L.VenomType.venomous
        } else {
            venomTypeColor = HerpiColor.VenomType.noVenomous
            venomTypeString = L.VenomType.noVenomous
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            KFImage(reptile.image.asURL())
                .placeholder({ Image(.placeholder) })
                .resizable()
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                .cornerRadius(Constants.imageCornerRadius)
                .skeleton(isLoading: isLoading)
            
            Text(reptile.name)
                .font(HerpiFont.semibold_13)
                .foregroundStyle(HerpiColor.Title.secondary)
                .skeleton(isLoading: isLoading)
                .padding(.top, Constants.titleTopPadding)
            
            Text(venomTypeString)
                .font(HerpiFont.semibold_10)
                .foregroundStyle(HerpiColor.white)
                .padding(.horizontal, Constants.venomousCardHorizontalPadding)
                .padding(.vertical, Constants.venomousCardVerticalPadding)
                .background(venomTypeColor)
                .cornerRadius(.infinity)
                .skeleton(isLoading: isLoading)
                .padding(.top, Constants.venomousCardTopPadding)
        }
    }
 
    struct Constants {
        static let imageCornerRadius: CGFloat = 12
        static let titleTopPadding: CGFloat = 8
        static let venomousCardTopPadding: CGFloat = 5
        static let venomousCardHorizontalPadding: CGFloat = 10
        static let venomousCardVerticalPadding: CGFloat = 4
        
        @MainActor static let imageWidth: CGFloat = (
            UIScreen.main.bounds.size.width - (
                NearbyReptilesCollection.Constants.gridSpacing +
                (2 * MainPageView.Constants.scrollViewHorizontalPadding)
            )
        ) / 2
        
        @MainActor static let imageHeight: CGFloat = (Constants.imageWidth / 17) * 9
    }
}

#Preview {
    NearbyReptileCard(reptile: mockNearbyReptile1, isLoading: false)
}
