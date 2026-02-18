//
//  AppFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 01.02.26.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct AppFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var isAppLoading: Bool = true
        var menuWidth: CGFloat = 330
        var dimmingOverlayOpacity: Double = 0.6
        var menuOffset: CGFloat = .zero
        var menuLastDragOffset: CGFloat = .zero
        var menuDragProgress: CGFloat = .zero
        var isHorizontalDrag: Bool = false
        var locationPickerSheetShown: Bool = false
        var currentLanguage: AppLanguage.Language = AppLanguage.currentLanguage
        
        var navigation = NavigationFeature.State()
        var menu = MenuFeature.State()
        var mainPage = MainPageView.Feature.State()
        var teamPage = TeamPageFeature.State()
        var faqPage = FAQPageFeature.State()
    }
    
    // MARK: - Action
    enum Action {
        case onAppear
        case appLoadingFinished
        case closeMenu
        case menuButtonTapped
        case pickLocationTapped
        case chatButtonTapped
        
        case menuDragChanged(DragGesture.Value)
        case menuDragEnded(DragGesture.Value)
        
        case navigation(NavigationFeature.Action)
        case menu(MenuFeature.Action)
        case mainPage(MainPageView.Feature.Action)
        case teamPage(TeamPageFeature.Action)
        case faqPage(FAQPageFeature.Action)
    }
    
    // MARK: - Dependencies
    @Dependency(\.openURL) var openURL
    
    var body: some Reducer<State, Action> {        
        Reduce { state, action in
            switch action {
                // MARK: UI Actions
            case .onAppear:
                return .run { send in
                    try await Task.sleep(for: .seconds(2))
                    await send(.appLoadingFinished, animation: .default)
                }
                
            case .appLoadingFinished:
                state.isAppLoading = false
                return .none
                
            case .menuButtonTapped:
                withAnimation(.snappy(duration: 0.25, extraBounce: .zero)) {
                    state.menuOffset = state.menuWidth
                    state.menuDragProgress = state.menuOffset / state.menuWidth
                    state.menuLastDragOffset = state.menuOffset
                }
                return .none
                
            case .pickLocationTapped:
                state.locationPickerSheetShown.toggle()
                return .none
                
            case .chatButtonTapped:
                AppAnalytics.logEvents(with: .click_chat)
                
                return .run { _ in
                    if let url = URL(string: AppConstants.chatUrl) {
                        await openURL(url)
                    }
                }
                
            case .closeMenu:
                withAnimation(.snappy(duration: 0.25, extraBounce: .zero)) {
                    state.menuOffset = .zero
                    state.menuDragProgress = .zero
                }
                state.menuLastDragOffset = .zero
                return .none
                
            case .menuDragChanged(let value):
                if !state.isHorizontalDrag {
                    let h = abs(value.translation.width)
                    let v = abs(value.translation.height)
                    
                    if h > 50 && h > v * 1.5 {
                        state.isHorizontalDrag = true
                    } else {
                        return .none
                    }
                }
                
                let translation = value.translation.width + state.menuLastDragOffset
                let clamped = max(min(translation, state.menuWidth), .zero)
                
                state.menuOffset = clamped
                state.menuDragProgress = clamped / state.menuWidth
                return .none
                
            case .menuDragEnded(let value):
                state.isHorizontalDrag = false
                let velocity = value.translation.width / 3
                
                if (velocity + state.menuOffset) > state.menuWidth * 0.3 {
                    state.menuOffset = state.menuWidth
                } else {
                    state.menuOffset = .zero
                }
                
                state.menuDragProgress = state.menuOffset / state.menuWidth
                state.menuLastDragOffset = state.menuOffset
                return .none
                
                // MARK: Navigation
            case .navigation:
                return .none
                
                // MARK: Child features
            case .menu(.didChangeMenuState(_)):
                return .run { send in
                    await send(.closeMenu, animation: .default)
                }
                
            case .menu(.didSwitchedLanguage(_)):
                state.currentLanguage = AppLanguage.currentLanguage
                return .none
                
            case .menu:
                return .none
                
            case .mainPage(.push(let destination)):
                return .send(.navigation(.push(destination)))
                
            case .mainPage:
                return .none
                
            case .teamPage:
                return .none
                
            case .faqPage:
                return .none
            }
        }
        
        // MARK: - Child reducers
        Scope(
            state: \.navigation,
            action: \.navigation
        ) {
            NavigationFeature()
        }
        
        Scope(
            state: \.menu,
            action: \.menu
        ) {
            MenuFeature()
        }
        
        Scope(
            state: \.mainPage,
            action: \.mainPage
        ) {
            MainPageView.Feature()
        }
        
        Scope(
            state: \.teamPage,
            action: \.teamPage
        ) {
            TeamPageFeature()
        }
        
        Scope(
            state: \.faqPage,
            action: \.faqPage
        ) {
            FAQPageFeature()
        }
    }
}
