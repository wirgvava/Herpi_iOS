//
//  View+Extensions.swift
//  HerpiFoundation
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//

import SwiftUI

public extension View {
    func topCornerRadius(_ radius: CGFloat) -> some View {
        clipShape(TopRoundedCorner(radius: radius))
    }
    
    func skeleton<S>(
        _ shape: S? = nil as Rectangle?,
        isLoading: Bool
    ) -> some View where S: Shape {
        guard isLoading else { return AnyView(self) }
        let skeletonColor = Color.gray.opacity(0.3)
        
        let skeletonShape: AnyShape = if let shape {
            AnyShape(shape)
        } else {
            AnyShape(RoundedRectangle(cornerRadius: 10))
        }
        
        return AnyView(
            opacity(0)
                .overlay(skeletonShape.fill(skeletonColor))
        )
    }
}

fileprivate struct TopRoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = [.topLeft, .topRight]
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
