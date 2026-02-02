//
//  LanguageSwitcher.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//

import SwiftUI

public struct LanguageSwitcher: View {
    private var selectedIndex: Int
    private var action: (Int) -> Void
    
    // - Init
    public init(selectedIndex: Int, action: @escaping (Int) -> Void){
        self.selectedIndex = selectedIndex
        self.action = action
    }
    
    // - Body
    public var body: some View {
        HStack {
            Text("GEO")
                .font(HerpiFont.semibold_16)
                .foregroundColor(selectedIndex == .zero ? HerpiColor.creme : HerpiColor.white)
                .onTapGesture { action(.zero) }
            
            Rectangle()
                .fill(HerpiColor.dark)
                .frame(width: .one, height: Constants.halfOfHeight)
            
            Text("ENG")
                .font(HerpiFont.semibold_16)
                .foregroundColor(selectedIndex == .one ? HerpiColor.creme : HerpiColor.white)
                .onTapGesture { action(.one) }
        }
        .frame(width: Constants.width, height: Constants.height)
        .background(HerpiColor.white.opacity(Constants.opacity))
        .cornerRadius(Constants.halfOfHeight)
    }
    
    struct Constants {
        static let width: CGFloat = 125
        static let height: CGFloat = 32
        static let halfOfHeight: CGFloat = 16
        static let opacity: Double = 0.5
    }
}
