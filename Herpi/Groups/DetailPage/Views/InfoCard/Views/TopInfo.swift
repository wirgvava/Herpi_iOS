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
        var isLoading: Bool
        
        var body: some View {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: .zero) {
                    Text(info.name)
                        .font(HerpiFont.bold_16)
                        .foregroundStyle(HerpiColor.Title.primary)
                        .skeleton(isLoading: isLoading)
                    
                    Text(info.scientificName)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.secondary)
                        .skeleton(isLoading: isLoading)
                        .padding(.top, Constants.secondTitleTopPadding)
                    
                    Text(info.family.name)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.green)
                        .skeleton(isLoading: isLoading)
                        .padding(.top, Constants.thirdTitleTopPadding)
                }
                
                Spacer()
                
                Text(venomTypeString(hasMildVenom: info.hasMildVenom, venomous: info.venomous))
                    .font(HerpiFont.semibold_13)
                    .foregroundStyle(HerpiColor.white)
                    .padding(.horizontal, Constants.venomBadgeHorizontalPadding)
                    .padding(.vertical, Constants.venomBadgeVerticalPadding)
                    .background(venomTypeColor(hasMildVenom: info.hasMildVenom, venomous: info.venomous))
                    .skeleton(isLoading: isLoading)
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
