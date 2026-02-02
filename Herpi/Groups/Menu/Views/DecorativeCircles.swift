//
//  DecorativeCircles.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//

import SwiftUI

extension MenuView {
    struct DecorativeCircles: View {
        var body: some View {
            ZStack {
                ForEach(Constants.circleWidths, id: \.self) { width in
                    decorativeCircle(width: width)
                }
            }
            .padding(.top, Constants.topPadding)
            .padding(.leading, Constants.leadingPadding)
            .padding(.trailing, Constants.trailingPadding)
            .ignoresSafeArea()
        }
        
        private func decorativeCircle(width: CGFloat) -> some View {
            Circle()
                .fill(.white.opacity(Constants.fillOpacity))
                .aspectRatio(.one, contentMode: .fit)
                .frame(width: width)
        }
        
        struct Constants {
            static let fillOpacity: Double = 0.04
            static let topPadding: CGFloat = -210
            static let leadingPadding: CGFloat = -180
            static let trailingPadding: CGFloat = 30
            
            static let circleWidths: [CGFloat] = [480, 370, 260, 150]
        }
    }
}
