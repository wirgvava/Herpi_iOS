//
//  TeamModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 15.02.24.
//

import Foundation

struct TeamModelElement: Codable {
    let id: Int?
    let firstName, lastName: String?
    let avatar: String?
    let email: String?
    let socialNetworks: [SocialNetwork]?
    let role: String?
}

// MARK: - SocialNetwork
struct SocialNetwork: Codable {
    let id: Int?
    let network: String?
    let networkLogoUrl: String?
    let username: String?
    let url: String?
}

typealias TeamModel = [TeamModelElement]

struct TeamData {
    var opened: Bool
    var teamElement: TeamModelElement
}

