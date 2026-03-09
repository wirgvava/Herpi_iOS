//
//  TeamMemberCard.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.02.26.
//

import SwiftUI
import HerpiUI
import HerpiModels

struct TeamMemberCard: View {
    
    let member: TeamMember
    
    let didTapOnEmail: () -> Void
    let didTapOnSocialNetwork: (SocialNetwork) -> Void
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(spacing: Constants.vstackSpacing) {
            HStack(alignment: .top, spacing: Constants.hstackSpacing) {
                CachedAsyncImage(url: member.avatar, placeholder: {
                    Image(.placeholder)
                        .resizable()
                        .aspectRatio(.one, contentMode: .fill)
                })
                .aspectRatio(.one, contentMode: .fill)
                .frame(width: Constants.avatarWidth)
                .clipShape(.circle)
                
                VStack(alignment: .leading) {
                    Text(member.fullName)
                        .font(HerpiFont.bold_16)
                        .foregroundStyle(HerpiColor.Title.primary)
                    
                    Text(member.email)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.green)
                        .onTapGesture { didTapOnEmail() }
                    
                    Text(member.role)
                        .font(HerpiFont.semibold_13)
                        .foregroundStyle(HerpiColor.Title.secondary)
                }
                
                Spacer()
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    }
                    Spacer()
                }
            }
            
            if isExpanded {
                HStack(spacing: Constants.socialSpacing) {
                    ForEach(member.socialNetworks) { social in
                        CachedAsyncImage(url: social.networkLogoUrl)
                            .aspectRatio(.one, contentMode: .fit)
                            .frame(width: Constants.socialNetworkLogoWidth)
                            .onTapGesture {
                                didTapOnSocialNetwork(social)
                            }
                    }
                    
                    Spacer()
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(.horizontal, Constants.cardHorizontalPadding)
        .padding(.vertical, Constants.cardVerticalPadding)
        .background(HerpiColor.white)
        .cornerRadius(Constants.cardCornerRadius)
        .onTapGesture {
            withAnimation(.snappy) {
                isExpanded.toggle()
            }
        }
    }
    
    struct Constants {
        static let hstackSpacing: CGFloat = 15
        static let vstackSpacing: CGFloat = 12
        static let avatarWidth: CGFloat = 60
        static let socialNetworkLogoWidth: CGFloat = 40
        static let socialSpacing: CGFloat = 12
        static let cardHorizontalPadding: CGFloat = 15
        static let cardVerticalPadding: CGFloat = 20
        static let cardCornerRadius: CGFloat = 16
    }
}
