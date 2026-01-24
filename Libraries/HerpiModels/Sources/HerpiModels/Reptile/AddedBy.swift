//
//  AddedBy.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct AddedBy: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var firstName: String
    public var lastName: String
    public var avatar: String
    
    public init(
        id: Int = .zero,
        firstName: String = .empty,
        lastName: String = .empty,
        avatar: String = .empty
    ) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
    }
}

// MARK: - Mock
public let mockAddedBy: AddedBy = .init(
    id: 0,
    firstName: "Giorgi",
    lastName: "Gigauri",
    avatar: "https://api.herpi.ge/uploads/avatar"
)
