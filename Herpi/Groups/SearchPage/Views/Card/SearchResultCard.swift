//
//  SearchResultCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 17.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

struct SearchResultCard: View {
    
    var reptile: SearchedData
    
    var body: some View {
        HStack(alignment: .top, spacing: Constants.hstackSpacing) {
            CachedAsyncImage(url: reptile.image)
                .frame(width: Constants.imageWidth, height: Constants.imageHeight)
                .cornerRadius(Constants.imageCornerRadius)
            
            VStack(alignment: .leading) {
                Text(reptile.name)
                    .font(HerpiFont.semibold_14)
                    .foregroundStyle(HerpiColor.Title.primary)
                
                Text(reptile.scientificName)
                    .font(HerpiFont.regular_14)
                    .foregroundStyle(HerpiColor.Title.secondary)
                
                Text(venomTypeString(hasMildVenom: reptile.hasMildVenom, venomous: reptile.venomous))
                    .font(HerpiFont.semibold_10)
                    .foregroundStyle(HerpiColor.white)
                    .padding(.vertical, Constants.venomousVerticalPadding)
                    .padding(.horizontal, Constants.venomousHorizontalPadding)
                    .background(venomTypeColor(hasMildVenom: reptile.hasMildVenom, venomous: reptile.venomous))
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
