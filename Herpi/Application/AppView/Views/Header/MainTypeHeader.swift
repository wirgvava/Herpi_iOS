//
//  MainTypeHeader.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 02.02.26.
//

import SwiftUI
import HerpiUI

extension Header {
    struct MainTypeHeader: View {
        
        var pickLocationAction: () -> Void
        
        var body: some View {
            VStack(spacing: Constants.verticalSpacing) {
                Text(L.MainPage.Header.region)
                    .font(HerpiFont.semibold_15)
                    .foregroundStyle(HerpiColor.white.opacity(Constants.regionTitleOpacity))
                
                Button {
                    pickLocationAction()
                } label: {
                    HStack {
                        Image(.locationTick)
                            .resizable()
                            .aspectRatio(.one, contentMode: .fit)
                            .frame(width: Constants.locationTickWidth)
                            .foregroundStyle(HerpiColor.white)
                        
                        Text(L.MainPage.Header.pickLocation)
                            .font(HerpiFont.semibold_16)
                            .foregroundStyle(HerpiColor.white)
                    }
                }
            }
        }
        
        struct Constants {
            static let regionTitleOpacity: CGFloat = 0.8
            static let verticalSpacing: CGFloat = 5
            static let locationTickWidth: CGFloat = 22
        }
    }
}
