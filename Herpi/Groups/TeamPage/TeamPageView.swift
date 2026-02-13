//
//  TeamPageView.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.02.26.
//

import SwiftUI
import HerpiUI
import ComposableArchitecture

struct TeamPageView: View {
    
    let store: StoreOf<TeamPageFeature>
    
    var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.vstackSpacing) {
                    Text(L.Menu.team)
                        .font(HerpiFont.bold_16)
                        .foregroundStyle(HerpiColor.Title.primary)
                    
                    ForEach(store.team) { member in
                        WithPerceptionTracking {
                            TeamMemberCard(
                                member: member,
                                didTapOnEmail: {
                                    store.send(.didTapOnEmail(member.email))
                                },
                                didTapOnSocialNetwork: { social in
                                    store.send(
                                        .didTapOnSocialNetwork(
                                            member.email,
                                            social
                                        )
                                    )
                                }
                            )
                            .skeleton(isLoading: store.isLoading)
                        }
                    }
                }
                .padding(.vertical, Constants.vstackSpacing)
                .padding(.horizontal, Constants.horizontalPadding)
                .onAppear {
                    store.send(.fetchTeam)
                }
            }
            .background(HerpiColor.background)
            .topCornerRadius(Constants.scrollViewCornerRadius)
            .ignoresSafeArea()
        }
    }
    
    struct Constants {
        static let vstackSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 20
        static let scrollViewCornerRadius: CGFloat = 32
    }
}

#Preview {
    TeamPageView(store: .init(initialState: TeamPageFeature.State(), reducer: { TeamPageFeature() }))
}
