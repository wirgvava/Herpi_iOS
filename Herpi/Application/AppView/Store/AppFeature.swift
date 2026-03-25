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
        var currentLocation: String = .empty
        var currentLanguage: AppLanguage.Language = AppLanguage.currentLanguage
        var errorMessage: String? = nil
        
        var sideMenu = SideMenuFeature.State()
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
        case pickLocationTapped
        case chatButtonTapped
        case handleDeepLink(URL)
        
        case sideMenu(SideMenuFeature.Action)
        case navigation(NavigationFeature.Action)
        case menu(MenuFeature.Action)
        case mainPage(MainPageView.Feature.Action)
        case teamPage(TeamPageFeature.Action)
        case faqPage(FAQPageFeature.Action)
        case showError(String)
        case dismissError
    }
    
    // MARK: - Dependencies
    @Dependency(\.openURL) var openURL
    @Dependency(\.dataSyncClient) var dataSyncClient
    
    var body: some Reducer<State, Action> {
        Scope(state: \.sideMenu, action: \.sideMenu) {
            SideMenuFeature()
        }
        
        Scope(state: \.navigation, action: \.navigation) {
            NavigationFeature()
        }
        
        Scope(state: \.menu, action: \.menu) {
            MenuFeature()
        }
        
        Scope(state: \.mainPage, action: \.mainPage) {
            MainPageView.Feature()
        }
        
        Scope(state: \.teamPage, action: \.teamPage) {
            TeamPageFeature()
        }
        
        Scope(state: \.faqPage, action: \.faqPage) {
            FAQPageFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    // Start background data sync
                    await dataSyncClient.startSync()
                    
                    // Minimum loading time for splash screen
                    try await Task.sleep(for: .seconds(2))
                    await send(.appLoadingFinished, animation: .default)
                }
                
            case .appLoadingFinished:
                state.isAppLoading = false
                return .none
                
            case .pickLocationTapped:
                AppAnalytics.log(AppAnalytics.Interaction.clickedPickLocationManually)
                return .send(.mainPage(.location(.setPickLocationSheetPresented(true))))
                
            case .chatButtonTapped:
                AppAnalytics.log(AppAnalytics.Interaction.clickedChat)
                return .run { _ in
                    if let url = URL(string: AppConstants.chatUrl) {
                        await openURL(url)
                    }
                }
                
            case .handleDeepLink(let url):
                guard let reptileId = parseReptileId(from: url) else { return .none }
                return .send(.navigation(.push(.reptileDetail(.init(reptileId: reptileId)))))
                
            // MARK: Child feature actions
            case .menu(.didChangeMenuState(_)):
                return .send(.sideMenu(.close), animation: .default)
                
            case .menu(.didSwitchedLanguage(_)):
                state.currentLanguage = AppLanguage.currentLanguage
                return .none
                
            case .mainPage(.push(let destination)):
                return .send(.navigation(.push(destination)))
                
            case .mainPage(.location(.reverseGeocodeResponse(let currentLocation))):
                state.currentLocation = currentLocation
                return .none
                
            case .showError(let message):
                state.errorMessage = message
                return .run { send in
                    try await Task.sleep(for: .seconds(5))
                    await send(.dismissError, animation: .easeOut)
                }
                
            case .dismissError:
                state.errorMessage = nil
                return .none
                
            case .mainPage(.didFailWithError(let message)):
                return .send(.showError(message))
                
            case .teamPage(.didFailWithError(let message)):
                return .send(.showError(message))
                
            case .faqPage(.didFailWithError(let message)):
                return .send(.showError(message))
                
            case .navigation(.didFailWithError(let message)):
                return .send(.showError(message))
                
            case .sideMenu, .navigation, .menu, .mainPage, .teamPage, .faqPage:
                return .none
            }
        }
    }
    
    // MARK: - Deep Link Parsing
    private func parseReptileId(from url: URL) -> Int? {
        let pathComponents = url.pathComponents
        guard pathComponents.count >= 3,
              pathComponents[1] == "reptiles",
              let reptileId = Int(pathComponents[2]) else {
            return nil
        }
        return reptileId
    }
}
