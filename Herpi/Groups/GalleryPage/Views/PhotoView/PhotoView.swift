//
//  PhotoView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 27.02.26.
//

import SwiftUI
import Kingfisher

struct PhotoView: View {
    let url: String
    @Binding var isZooming: Bool
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    private var isZoomed: Bool { scale > 1.0 }
    
    var body: some View {
        GeometryReader { geometry in
            KFImage(url.asURL())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(scale)
                .offset(offset)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let delta = value / lastScale
                            lastScale = value
                            scale = min(max(scale * delta, 1.0), Constants.maxZoom)
                            isZooming = scale > 1.0
                        }
                        .onEnded { _ in
                            lastScale = 1.0
                            if scale <= 1.0 {
                                withAnimation(.spring()) {
                                    scale = 1.0
                                    offset = .zero
                                    lastOffset = .zero
                                    isZooming = false
                                }
                            }
                        }
                )
                .simultaneousGesture(
                    DragGesture(minimumDistance: isZoomed ? .zero : .infinity)
                        .onChanged { value in
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            lastOffset = offset
                        }
                )
                .simultaneousGesture(
                    TapGesture(count: 2)
                        .onEnded {
                            withAnimation(.spring()) {
                                if scale > 1.0 {
                                    scale = 1.0
                                    offset = .zero
                                    lastOffset = .zero
                                    isZooming = false
                                } else {
                                    scale = Constants.doubleTapZoom
                                    isZooming = true
                                }
                            }
                        }
                )
        }
    }
    
    struct Constants {
        static let maxZoom: CGFloat = 4.0
        static let doubleTapZoom: CGFloat = 2.5
    }
}
