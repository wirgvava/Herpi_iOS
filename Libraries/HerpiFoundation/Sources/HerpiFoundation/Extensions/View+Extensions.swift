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
