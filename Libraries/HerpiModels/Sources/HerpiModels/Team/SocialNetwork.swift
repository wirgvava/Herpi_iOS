//
//  SocialNetwork.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct SocialNetwork: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var network: String
    public var networkLogoUrl: String
    public var username: String
    public var url: String
    
    public init(
        id: Int = .zero,
        network: String = .empty,
        networkLogoUrl: String = .empty,
        username: String = .empty,
        url: String = .empty
    ) {
        self.id = id
        self.network = network
        self.networkLogoUrl = networkLogoUrl
        self.username = username
        self.url = url
    }
}

// MARK: - Mock
public let mockSocialNetwork1: SocialNetwork = .init(
    id: 360452,
    network: "Facebook",
    networkLogoUrl: "https://herpi.ge/static/media/facebook.01a470d813915c298403.png",
    username: "giorgii.gigauri",
    url: "https://www.facebook.com/giorgii.gigauri"
)

public let mockSocialNetwork2: SocialNetwork = .init(
    id: 360453,
    network: "LinkedIn",
    networkLogoUrl: "https://herpi.ge/static/media/linkedin.6892b3ae328c7a1e055f.png",
    username: "giorgi-gigauri-934a301a8",
    url: "https://www.linkedin.com/in/giorgi-gigauri-934a301a8/"
)

public let mockSocialNetwork3: SocialNetwork = .init(
    id: 360454,
    network: "GitHub",
    networkLogoUrl: "https://cdn-icons-png.flaticon.com/512/25/25231.png",
    username: "george-gigauri",
    url: "https://www.github.com/george-gigauri"
)

public let mockSocialNetwork4: SocialNetwork = .init(
    id: 393216,
    network: "Facebook",
    networkLogoUrl: "https://herpi.ge/static/media/facebook.01a470d813915c298403.png",
    username: "wirgvava",
    url: "https://www.facebook.com/wirgvava"
)

public let mockSocialNetwork5: SocialNetwork = .init(
    id: 393217,
    network: "LinkedIn",
    networkLogoUrl: "https://herpi.ge/static/media/linkedin.6892b3ae328c7a1e055f.png",
    username: "konstantine-tsirgvava",
    url: "https://www.linkedin.com/in/konstantine-tsirgvava"
)

public let mockSocialNetwork6: SocialNetwork = .init(
    id: 393218,
    network: "GitHub",
    networkLogoUrl: "https://cdn-icons-png.flaticon.com/512/25/25231.png",
    username: "wirgvava",
    url: "https://www.github.com/wirgvava"
)
