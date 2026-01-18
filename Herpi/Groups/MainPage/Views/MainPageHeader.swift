//
//  MainPageHeader.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI
import HerpiUI
import HerpiFoundation

extension MainPageView {
    struct Header: View {
        var menuAction: () -> Void
        var pickLocationAction: () -> Void
        var chatAction: () -> Void
        
        var body: some View {
            HStack {
                MenuButton { menuAction() }
                
                Spacer()
                
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
                
                Spacer()
                
                ChatButton { chatAction() }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
        }
        
        struct Constants {
            static let regionTitleOpacity: CGFloat = 0.8
            static let verticalSpacing: CGFloat = 5
            static let locationTickWidth: CGFloat = 22
            static let horizontalPadding: CGFloat = 20
            static let verticalPadding: CGFloat = 15
        }
    }
}

#Preview {
    MainPageView.Header(
        menuAction: { },
        pickLocationAction: { },
        chatAction: { }
    )
    .background(HerpiColor.tint)
}
