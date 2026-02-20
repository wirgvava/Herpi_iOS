//
//  InfoCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

extension DetailPageView {
    struct InfoCard: View {
        var info: DetailedInfoModel
        
        var body: some View {
            VStack {
                TopInfo(info: info)
                RedFlagDescription()
                Author(info: info)
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .background(HerpiColor.background)
            .cornerRadius(Constants.cornerRadius)
            .padding(.top, Constants.outsideTopPadding)
            .shadow(
                color: Constants.shadowColor,
                radius: Constants.shadowRadius,
                x: Constants.shadowOffset,
                y: Constants.shadowOffset
            )
        }
        
        struct Constants {
            static let horizontalPadding: CGFloat = 18
            static let verticalPadding: CGFloat = 23
            static let outsideTopPadding: CGFloat = -62
            static let cornerRadius: CGFloat = 24
            static let shadowColor: Color = .gray.opacity(0.5)
            static let shadowRadius: CGFloat = 8
            static let shadowOffset: CGFloat = -1
        }
    }
}
