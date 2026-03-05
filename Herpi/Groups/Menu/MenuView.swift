//
//  MenuView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 31.01.26.
//

import SwiftUI
import HerpiUI
import HerpiFoundation
import ComposableArchitecture

struct MenuView: View {
    
    let store: StoreOf<MenuFeature>
        
    var body: some View {
        VStack(alignment: .leading) {
            // Decorative Circles
            DecorativeCircles()
            
            VStack(alignment: .leading) {
                Spacer()
                // Menu Buttons
                ForEach(MenuStates.allCases, id: \.rawValue) { menu in
                    Text(menu.title)
                        .foregroundStyle(store.menuState == menu ? HerpiColor.creme : HerpiColor.white)
                        .font(HerpiFont.semibold_16)
                        .padding(.bottom, Constants.paddingBetweenButtons)
                        .onTapGesture {
                            store.send(.didChangeMenuState(menu))
                        }
                }
                
                Spacer()
                
                // Language Switcher
                LanguageSwitcher(
                    selectedIndex: AppLanguage.currentLanguage == .ka ? .zero : .one
                ) { selectedIndex in
                    store.send(.didSwitchedLanguage(selectedIndex))
                }
            }
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.bottom, Constants.bottomPadding)
        }
        .background(HerpiColor.tint)
        .rightCornerRadius(Constants.cornerRadius)
        .ignoresSafeArea()
    }
    
    struct Constants {
        static let paddingBetweenButtons: CGFloat = 20
        static let horizontalPadding: CGFloat = 30
        static let bottomPadding: CGFloat = 64
        static let cornerRadius: CGFloat = 32
    }
}

// - Helpers
fileprivate extension View {
    func rightCornerRadius(_ radius: CGFloat) -> some View {
        clipShape(RightRoundedCorner(radius: radius))
    }
}

fileprivate struct RightRoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = [.topRight, .bottomRight]
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    MenuView(
        store: Store(
            initialState: MenuFeature.State()
        ) {
            MenuFeature()
        }
    )
}
