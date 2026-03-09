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
        var team: TeamModel = mockTeam /// default data for skeleton animation.
        var isLoading: Bool = false
    }
    
    // MARK: - Action
    enum Action {
        case fetchTeam
        case didReceivedResponse(TeamModel)
        case didFailWithError(String)
        case didTapOnEmail(String)
        case didTapOnSocialNetwork(String, SocialNetwork)
    }
    
    // MARK: - Dependencies
    @Dependency(\.openURL) var openURL
    @Dependency(\.apiClient) var apiClient
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .fetchTeam:
                state.isLoading = true
                
                return .run { send in
                    let team = try await apiClient.fetchTeam()
                    await send(.didReceivedResponse(team))
                } catch: { error, send in
                    await send(.didFailWithError(error.localizedDescription))
                }
                
            case .didReceivedResponse(let team):
                state.isLoading = false
                state.team = team
                return .none
                
            case .didFailWithError:
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
