//
//  TeamPageFeature.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.02.26.
//

import SwiftUI
import HerpiModels
import ComposableArchitecture

@Reducer
struct TeamPageFeature {
    
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var team: TeamModel = mockTeam
        var isLoading: Bool = false
    }
    
    // MARK: - Action
    enum Action {
        case fetchTeam
        case didReceivedResponse(TeamModel)
        case didTapOnEmail(String)
        case didTapOnSocialNetwork(String, SocialNetwork)
    }
    
    // MARK: - Dependencies
    @Dependency(\.openURL) var openURL
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchTeam:
                state.isLoading = true
                return .run { send in
                    let team: TeamModel = mockTeam
                    await send(.didReceivedResponse(team))
                }
                
            case .didReceivedResponse(let team):
                state.isLoading = false
                state.team = team
                return .none
                
            case .didTapOnEmail(let email):
                AppAnalytics.logEvents(with: .click_team_email, paramName: .member, paramData: email)
                
                return .run { _ in
                    if let url = URL(string: "mailto:\(email)") {
                        await openURL(url)
                    }
                }
                
            case .didTapOnSocialNetwork(let email, let social):
                AppAnalytics.logEvents(
                    with: .click_team_social_link,
                    parameters: [
                        "member" : email,
                        "network" : social.network
                    ]
                )
                
                return .run { _ in
                    if let url = URL(string: social.url) {
                        await openURL(url)
                    }
                }
            }
        }
    }
}
