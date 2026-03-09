//
//  ReptilesListCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 25.01.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

struct ReptilesListCard: View {
    
    var reptile: ReptileModel
    var isLoading: Bool
    
    var body: some View {
        HStack {
            // Info
            VStack(alignment: .leading, spacing: .zero) {
                /// Information about `venomous` type.
                HStack(spacing: Constants.venomInfoPadding) {
                    Image(.infoIcon)
                        .resizable()
                        .foregroundStyle(venomTypeColor(hasMildVenom: reptile.hasMildVenom, venomous: reptile.venomous))
                        .aspectRatio(.one, contentMode: .fit)
                        .frame(width: Constants.infoIconWidth)
                    
                    Text(venomTypeString(hasMildVenom: reptile.hasMildVenom, venomous: reptile.venomous))
                        .font(HerpiFont.semibold_12)
                        .foregroundStyle(HerpiColor.Title.secondary)
                }
                .padding(.bottom, Constants.venomInfoBottomPadding)
                
                /// Reptile `name` and `family name`.
                Text(reptile.family.name)
                    .font(HerpiFont.regular_13)
                    .foregroundStyle(HerpiColor.Title.secondary)
                
                Text(reptile.name)
                    .font(HerpiFont.bold_15)
                    .foregroundStyle(HerpiColor.Title.secondary)
                
                Spacer()
                
                /// `Read More` button.
                Text(L.MainPage.ReptilesList.readMoreBtn)
                    .font(HerpiFont.semibold_12)
                    .foregroundStyle(HerpiColor.white)
                    .frame(height: Constants.readMoreBtnHeight)
                    .padding(.horizontal, Constants.readMoreBtnHorizontalPadding)
                    .background(HerpiColor.tint)
                    .cornerRadius(Constants.readMoreBtnCornerRadius)
            }
            .padding(Constants.infoVStackPadding)
            
            Spacer()
            
            // Image
            CachedAsyncImage(url: reptile.transparentThumbnail)
                .aspectRatio(.one, contentMode: .fit)
                .frame(height: Constants.imageHeight)
            
        }
        .background(HerpiColor.white)
        .cornerRadius(Constants.cardCornerRadius)
        .skeleton(isLoading: isLoading)
    }
    
    struct Constants {
        static let cardCornerRadius: CGFloat = 16
        static let imageHeight: CGFloat = 175
        static let infoIconWidth: CGFloat = 14
        static let venomInfoPadding: CGFloat = 8
        static let venomInfoBottomPadding: CGFloat = 22
        static let readMoreBtnHeight: CGFloat = 32
        static let readMoreBtnHorizontalPadding: CGFloat = 12
        static let readMoreBtnCornerRadius: CGFloat = 16
        static let infoVStackPadding: CGFloat = 15
    }
}
