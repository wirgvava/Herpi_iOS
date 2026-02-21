//
//  Description.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

extension DetailPageView {
    struct Description: View {
        var info: DetailedInfoModel
        var isLoading: Bool
        
        var body: some View {
            VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                Text(L.DetailPage.description)
                    .font(HerpiFont.semibold_16)
                    .foregroundStyle(HerpiColor.Title.primary)
                    .skeleton(isLoading: isLoading)
                
                if isLoading {
                    ForEach(1..<6) { _ in
                        Rectangle()
                            .frame(height: Constants.loadingDescriptionHeight)
                            .skeleton(isLoading: isLoading)
                            .padding(.bottom, Constants.loadingDescrBottomPadding)
                    }
                } else {
                    Text(info.description)
                        .font(HerpiFont.regular_14)
                        .foregroundStyle(HerpiColor.Title.secondary)
                }
            }
        }
        
        struct Constants {
            static let vstackSpacing: CGFloat = 12
            static let horizontalPadding: CGFloat = 30
            static let loadingDescriptionHeight: CGFloat = 20
            static let loadingDescrBottomPadding: CGFloat = -6
        }
    }
}
