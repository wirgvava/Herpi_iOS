//
//  EmptyNearbyReptilesView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 24.01.26.
//

import SwiftUI
import HerpiUI

struct EmptyNearbyReptilesView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .fill(HerpiColor.creme)
            .frame(height: Constants.height)
            .overlay {
                Text(L.MainPage.NearbyReptiles.emptyList)
                    .font(HerpiFont.regular_14)
                    .foregroundStyle(HerpiColor.Title.secondary)
            }
    }
    
    struct Constants {
        static let cornerRadius: CGFloat = 16
        static let height: CGFloat = 200
    }
}

#Preview {
    EmptyNearbyReptilesView()
}
