//
//  PageControll.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 22.01.26.
//

import SwiftUI

public struct PageControll: View {
    private var pageCount: Int
    private var selectedPage: Int
    
    public init(pageCount: Int, selectedPage: Int) {
        self.pageCount = pageCount
        self.selectedPage = selectedPage
    }
    
    public var body: some View {
        HStack {
            ForEach(0..<pageCount, id: \.self) { page in
                Circle()
                    .frame(width: Constants.circleSize)
                    .foregroundStyle(selectedPage == page ? HerpiColor.tint : HerpiColor.tint.opacity(Constants.notActiveCircleOpacity))
            }
        }
    }
    
    struct Constants {
        static let circleSize: CGFloat = 8
        static let notActiveCircleOpacity: Double = 0.5
    }
}

#Preview {
    PageControll(pageCount: 6, selectedPage: 0)
}
