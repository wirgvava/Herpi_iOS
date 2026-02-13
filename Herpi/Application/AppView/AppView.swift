//
//  AppView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 01.02.26.
//

import SwiftUI
import HerpiUI
import ComposableArchitecture

struct AppView: View {
    
    let store: StoreOf<AppFeature>
            
    var body: some View {
        WithPerceptionTracking {
            if store.isAppLoading {
                LaunchPageView()
                    .onAppear {
                        store.send(.onAppear)
                    }
                
            } else {
                ZStack(alignment: .leading) {
                    
                    // MARK: - Content
                    VStack(spacing: .zero) {
                        Header(
                            menuAction: { store.send(.menuButtonTapped) },
                            pickLocationAction: { store.send(.pickLocationTapped) },
                            chatAction: { store.send(.chatButtonTapped) },
                            typeOfHeader: store.menu.menuState == .main ? .main : .other
                        )
                        
                        switch store.menu.menuState {
                        case .main:
                            MainPageView(
                                store: store.scope(
                                    state: \.mainPage,
                                    action: \.mainPage
                                )
                            )
                            
                        case .team:
                            TeamPageView(
                                store: store.scope(
                                    state: \.teamPage,
                                    action: \.teamPage
                                )
                            )
                            
                        case .faq:
                            FAQPageView(
                                store: store.scope(
                                    state: \.faqPage,
                                    action: \.faqPage
                                )
                            )
                        }
                    }
                    .background(HerpiColor.tint)
                    
                    // Dimming overlay - appears when sidebar is open
                    Rectangle()
                        .fill(.black.opacity(store.dimmingOverlayOpacity))
                        .ignoresSafeArea()
                        .opacity(store.menuDragProgress)
                        .allowsHitTesting(store.menuDragProgress > .zero)
                        .onTapGesture {
                            store.send(.closeMenu)
                        }
                    
                    // MARK: - Side Menu
                    MenuView(
                        store: store.scope(
                            state: \.menu,
                            action: \.menu
                        )
                    )
                    .frame(width: store.menuWidth)
                    .offset(x: store.menuOffset - store.menuWidth)
                }
                .id(store.currentLanguage)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { store.send(.menuDragChanged($0)) }
                        .onEnded { store.send(.menuDragEnded($0)) }
                )
            }
        }
    }
}

#Preview {
    AppView(
        store: Store(
            initialState: AppFeature.State()
        ) {
            AppFeature()
        }
    )
}
