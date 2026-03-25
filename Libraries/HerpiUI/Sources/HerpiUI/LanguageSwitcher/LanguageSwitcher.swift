//
//  LanguageSwitcher.swift
//  HerpiUI
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//

import SwiftUI
import HerpiFoundation

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
        HStack(spacing: .zero) {
            button(
                text: "GEO",
                foregroundColorState: selectedIndex == .zero,
                onTap: {
                    action(.zero)
                }
            )
            
            Rectangle()
                .fill(HerpiColor.dark)
                .frame(width: .one, height: Constants.halfOfHeight)
                .padding(.vertical)
                .background(HerpiColor.white.opacity(Constants.opacity))
     
            button(
                text: "ENG",
                foregroundColorState: selectedIndex == .one,
                onTap: {
                    action(.one)
                }
            )
        }
        .frame(width: Constants.width, height: Constants.height)
        .cornerRadius(Constants.halfOfHeight)
    }
    
    private func button(text: String, foregroundColorState: Bool, onTap: @escaping () -> Void) -> some View {
        Rectangle()
            .fill(HerpiColor.white.opacity(Constants.opacity))
            .overlay {
                Text(text)
                    .font(HerpiFont.semibold_16)
                    .foregroundColor(foregroundColorState ? HerpiColor.creme : HerpiColor.white)
                    .onTapGesture {
                        HapticsManager.selection.vibrate()
                        onTap()
                    }
            }
    }
    
    struct Constants {
        static let width: CGFloat = 125
        static let height: CGFloat = 32
        static let halfOfHeight: CGFloat = 16
        static let opacity: Double = 0.5
    }
}
