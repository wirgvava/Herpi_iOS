//
//  TeamModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct TeamMember: Codable, Sendable, Identifiable, Equatable {
    public let id: Int
    public var firstName, lastName: String
    public var avatar: String
    public var email: String
    public var socialNetworks: [SocialNetwork]
    public var role: String
    
    public var fullName: String {
        return firstName + " " + lastName
    }
    
    public var isExpanded: Bool = false
    
    public init(
        id: Int = .zero,
        firstName: String = .empty,
        lastName: String = .empty,
        avatar: String = .empty,
        email: String = .empty,
        socialNetworks: [SocialNetwork] = [],
        role: String = .empty
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.email = email
        self.socialNetworks = socialNetworks
        self.role = role
    }
}

public typealias TeamModel = [TeamMember]

// MARK: - Mock
public let mockTeam: TeamModel = [
    .init(
        id: 524288,
        firstName: "Giorgi",
        lastName: "Gigauri",
        avatar: "https://herpi.ge/static/media/developer_avatar.a3acf50f6454f292a164.jpg",
        email: "giorgigigauri7@gmail.com",
        socialNetworks: [mockSocialNetwork1, mockSocialNetwork2, mockSocialNetwork3],
        role: "Owner, Android, Backend "
    ),
    .init(
        id: 557056,
        firstName: "Konstantine",
        lastName: "Tsirgvava",
        avatar: "https://avatars.githubusercontent.com/u/43795921?s=400&u=10f1006d5f0575b07243453ff097a0700591169c&v=4",
        email: "koka.wirgvava@gmail.com",
        socialNetworks: [mockSocialNetwork4, mockSocialNetwork5, mockSocialNetwork6],
        role: "iOS Developer"
    )
]
