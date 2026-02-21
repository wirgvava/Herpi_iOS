//
//  RedFlagDescription.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI

extension DetailPageView.InfoCard {
    struct RedFlagDescription: View {
        var isLoading: Bool
        
        var body: some View {
            HStack {
                Text(L.DetailPage.redFlagDescription)
                    .font(HerpiFont.semibold_15)
                    .foregroundStyle(HerpiColor.white)
                    .padding(Constants.textPadding)
                    
                Spacer()
            }
            .background(HerpiColor.VenomType.venomous)
            .cornerRadius(Constants.cornerRadius)
            .skeleton(isLoading: isLoading)
            .padding(.top, Constants.topPadding)
            .padding(.bottom, Constants.bottomPadding)
        }
        
        struct Constants {
            static let textPadding: CGFloat = 20
            static let cornerRadius: CGFloat = 16
            static let topPadding: CGFloat = 16
            static let bottomPadding: CGFloat = 12
        }
    }
}
