//
//  SearchResultCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 17.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import Kingfisher

struct SearchResultCard: View {
    
    var reptile: SearchedData
    private var venomTypeString: String
    private var venomTypeColor: Color
    
    init(reptile: SearchedData) {
        self.reptile = reptile
        
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
        HStack(alignment: .top, spacing: Constants.hstackSpacing) {
            KFImage(reptile.image.asURL())
                .resizable()
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                .cornerRadius(Constants.imageCornerRadius)
            
            VStack(alignment: .leading) {
                Text(reptile.name)
                    .font(HerpiFont.semibold_14)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                Text(reptile.scientificName)
                    .font(HerpiFont.regular_14)
                    .foregroundStyle(HerpiColor.Title.secondary)
                
                Text(venomTypeString)
                    .font(HerpiFont.semibold_10)
                    .foregroundStyle(HerpiColor.white)
                    .padding(.vertical, Constants.venomousVerticalPadding)
                    .padding(.horizontal, Constants.venomousHorizontalPadding)
                    .background(venomTypeColor)
                    .clipShape(.capsule)
                    .padding(.top, Constants.venomousTopPadding)
            }
            
            Spacer()
        }
        .padding(.vertical, Constants.cardVerticalPadding)
        .background(HerpiColor.background)
    }
    
    struct Constants {
        static let hstackSpacing: CGFloat = 16
        static let imageWidth: CGFloat = 170
        static let imageHeight: CGFloat = 90
        static let imageCornerRadius: CGFloat = 16
        static let venomousVerticalPadding: CGFloat = 5
        static let venomousHorizontalPadding: CGFloat = 7
        static let venomousTopPadding: CGFloat = 12
        static let cardVerticalPadding: CGFloat = 10
    }
}
