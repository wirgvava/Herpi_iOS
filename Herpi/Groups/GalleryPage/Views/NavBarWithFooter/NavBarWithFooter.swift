//
//  NavBarWithFooter.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import HerpiUI

struct NavBarWithFooter: View {
    var navBarTitle: String
    var credits: String
    var isZooming: Bool
    var dismissAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(.backArrow)
                        .resizable()
                        .aspectRatio(.one, contentMode: .fit)
                        .frame(width: Constants.backButtonWidth)
                        .foregroundColor(isZooming ? HerpiColor.tint : HerpiColor.white)
                        .onTapGesture {
                            dismissAction()
                        }
                    
                    Text(navBarTitle)
                        .font(HerpiFont.regular_18)
                        .foregroundColor(isZooming ? HerpiColor.tint : HerpiColor.white)
                        .padding(.horizontal)
                }
                .padding()
                .background(
                    HerpiColor.white
                        .opacity(isZooming ? .infinity : .zero)
                        .clipShape(.capsule)
                )
                
                Spacer()
            }
            
            Spacer()
            
            Text(credits)
                .font(HerpiFont.regular_18)
                .foregroundStyle(isZooming ? HerpiColor.tint : HerpiColor.white)
                .padding()
                .background(
                    HerpiColor.white
                        .opacity(isZooming ? .infinity : .zero)
                        .clipShape(.capsule)
                )
        }
        .animation(.easeInOut, value: isZooming)
    }
    
    struct Constants {
        static let backButtonWidth: CGFloat = 25
        static let creditsPadding: CGFloat = 12
    }
}
