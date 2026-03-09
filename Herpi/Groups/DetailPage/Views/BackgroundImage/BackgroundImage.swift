//
//  BackgroundImage.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.02.26.
//

import SwiftUI
import HerpiUI

extension DetailPageView {
    struct BackgroundImage: View {
        var url: String
        private let imageHeight: CGFloat = 400
        private let gradientOpacity: Double = 0.8
        
        var body: some View {
            GeometryReader { geometry in
                let minY = geometry.frame(in: .global).minY
                let isStretching = minY > .zero
                
                CachedAsyncImage(url: url)
                    .scaledToFill()
                    .overlay {
                        LinearGradient(
                            colors: [
                                .black.opacity(gradientOpacity),
                                .clear
                            ],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    }
                    .frame(
                        width: geometry.size.width + (isStretching ? minY * 2 : .zero),
                        height: imageHeight + (isStretching ? minY : .zero)
                    )
                    .clipped()
                    .offset(x: isStretching ? -minY : .zero, y: isStretching ? -minY : .zero)
                    
            }
            .frame(height: imageHeight)
        }
    }
}
