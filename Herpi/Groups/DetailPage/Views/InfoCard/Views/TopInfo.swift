//
//  TopInfo.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

extension DetailPageView.InfoCard {
    struct TopInfo: View {
        var info: DetailedInfoModel
        
        private var venomTypeColor: Color = .clear
        private var venomTypeString: String = .empty
        
        init(info: DetailedInfoModel) {
            self.info = info
            
            if info.hasMildVenom {
                venomTypeColor = HerpiColor.VenomType.midVenomous
                venomTypeString = L.VenomType.midVenomous
            } else if info.venomous {
                venomTypeColor = HerpiColor.VenomType.venomous
                venomTypeString = L.VenomType.venomous
            } else {
                venomTypeColor = HerpiColor.VenomType.noVenomous
                venomTypeString = L.VenomType.noVenomous
            }
        }
        
        var body: some View {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(info.name)
                        .font(HerpiFont.bold_16)
                        .foregroundStyle(HerpiColor.Title.primary)
                    
                    Text(info.scientificName)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.secondary)
                        .padding(.top, Constants.secondTitleTopPadding)
                    
                    Text(info.family.name)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.green)
                        .padding(.top, Constants.thirdTitleTopPadding)
                }
                
                Spacer()
                
                Text(venomTypeString)
                    .font(HerpiFont.semibold_13)
                    .foregroundStyle(HerpiColor.white)
                    .padding(.horizontal, Constants.venomBadgeHorizontalPadding)
                    .padding(.vertical, Constants.venomBadgeVerticalPadding)
                    .background(venomTypeColor)
                    .clipShape(.capsule)
            }
        }
        
        struct Constants {
            static let secondTitleTopPadding: CGFloat = 5
            static let thirdTitleTopPadding: CGFloat = 12
            static let venomBadgeHorizontalPadding: CGFloat = 8
            static let venomBadgeVerticalPadding: CGFloat = 5
        }
    }
}
