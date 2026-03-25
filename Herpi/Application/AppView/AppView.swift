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
    
    @Bindable var store: StoreOf<AppFeature>
            
    var body: some View {
        if store.isAppLoading {
            LaunchPageView()
                .onAppear {
                    store.send(.onAppear)
                }
            
        } else {
            NavigationStack(
                path: $store.scope(
                    state: \.navigation.path,
                    action: \.navigation.path
                )
            ) {
                mainContent
            } destination: { store in
                NavigationDestinationView(store: store)
                    .navigationBarHidden(true)
            }
            .id(store.currentLanguage)
            .onOpenURL { url in
                store.send(.handleDeepLink(url))
            }
        }
    }
    
    // MARK: - Main Content
    private var mainContent: some View {
        ZStack(alignment: .leading) {
            
            // MARK: - Content
            VStack(spacing: .zero) {
                Header(
                    currentLocation: store.currentLocation,
                    menuAction: { store.send(.sideMenu(.open)) },
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
                .fill(.black.opacity(store.sideMenu.dimmingOverlayOpacity))
                .ignoresSafeArea()
                .opacity(store.sideMenu.dragProgress)
                .allowsHitTesting(store.sideMenu.dragProgress > .zero)
                .onTapGesture {
                    store.send(.sideMenu(.close))
                }
            
            // MARK: - Side Menu
            MenuView(
                store: store.scope(
                    state: \.menu,
                    action: \.menu
                )
            )
            .frame(width: store.sideMenu.width)
            .offset(x: store.sideMenu.offset - store.sideMenu.width)
            
            // MARK: - Error Alert
            ErrorAlert(
                title: store.errorMessage ?? .empty,
                isPresented: store.errorMessage != nil
            )
            .onTapGesture {
                store.send(.dismissError)
            }
        }
        .simultaneousGesture(
            store.mainPage.isCategoriesScrolling || store.mainPage.nearbyReptiles.isScrollingHorizontally ? nil :
            DragGesture()
                .onChanged { store.send(.sideMenu(.dragChanged($0))) }
                .onEnded { store.send(.sideMenu(.dragEnded($0))) }
        )
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
