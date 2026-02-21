//
//  Author.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels
import Kingfisher

extension DetailPageView.InfoCard {
    struct Author: View {
        var info: DetailedInfoModel
        var isLoading: Bool
        
        var body: some View {
            HStack(spacing: Constants.hstackSpacing) {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(L.DetailPage.author)
                        .font(HerpiFont.regular_12)
                        .foregroundStyle(HerpiColor.Title.secondary)
                    
                    Text(info.addedBy.fullName)
                        .font(HerpiFont.semibold_14)
                        .foregroundStyle(HerpiColor.Title.primary)
                }
                .skeleton(isLoading: isLoading)
                
                KFImage(info.addedBy.avatar.asURL())
                    .resizable()
                    .aspectRatio(.one, contentMode: .fit)
                    .frame(height: Constants.imageHeight)
                    .skeleton(isLoading: isLoading)
                    .clipShape(.circle)
            }
        }
        
        struct Constants {
            static let hstackSpacing: CGFloat = 9
            static let imageHeight: CGFloat = 40
        }
    }
}
