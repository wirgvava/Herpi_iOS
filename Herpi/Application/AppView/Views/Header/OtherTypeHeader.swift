//
//  OtherTypeHeader.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 02.02.26.
//

import SwiftUI
import HerpiUI

extension Header {
    struct OtherTypeHeader: View {
        var body: some View {
            HStack {
                Image(.logo)
                    .resizable()
                    .aspectRatio(.one, contentMode: .fit)
                    .frame(width: Constants.imageWidth)
                
                VStack(alignment: .leading) {
                    Text("HERPI.GE")
                        .foregroundStyle(HerpiColor.white)
                        .font(HerpiFont.bold_16)
                    
                    Text("www.herpi.ge")
                        .tint(HerpiColor.white.opacity(Constants.textOpacity))
                        .font(HerpiFont.semibold_13)
                }
            }
        }
        
        struct Constants {
            static let imageWidth: CGFloat = 40
            static let textOpacity: Double = 0.7
        }
    }
}
