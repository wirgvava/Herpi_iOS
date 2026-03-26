//
//  NearbyReptileModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct NearbyReptileModel: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var name: String
    public var scientificName: String
    public var family: Family
    public var type: String
    public var hasRedFlag: Bool
    public var hasMildVenom: Bool
    public var venomous: Bool
    public var image: String
    public var addedBy: AddedBy
    
    public init(
        id: Int = .zero,
        name: String = .empty,
        scientificName: String = .empty,
        family: Family = Family(),
        type: String = .empty,
        hasRedFlag: Bool = false,
        hasMildVenom: Bool = false,
        venomous: Bool = false,
        image: String = .empty,
        addedBy: AddedBy = AddedBy()
    ) {
        self.id = id
        self.name = name
        self.scientificName = scientificName
        self.family = family
        self.type = type
        self.hasRedFlag = hasRedFlag
        self.hasMildVenom = hasMildVenom
        self.venomous = venomous
        self.image = image
        self.addedBy = addedBy
    }
}

public typealias NearbyReptilesModel = [NearbyReptileModel]

// MARK: - Mock
public let mockNearbyReptile1: NearbyReptileModel = .init(
    id: 0,
    name: "Grass Snake",
    scientificName: "Natrix Natrix",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: false,
    venomous: true,
    image: "https://api.herpi.ge/uploads/file",
    addedBy: mockAddedBy
)

public let mockNearbyReptile2: NearbyReptileModel = .init(
    id: 1,
    name: "Smooth snake",
    scientificName: "Coronella austriaca",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: true,
    venomous: false,
    image: "https://api.herpi.ge/uploads/2182.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile3: NearbyReptileModel = .init(
    id: 2,
    name: "Schmidt's whip snake",
    scientificName: "Dolichophis schmidti",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: false,
    venomous: false,
    image: "https://api.herpi.ge/uploads/1899.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile4: NearbyReptileModel = .init(
    id: 3,
    name: "Lesser Asian Scorpion",
    scientificName: "Mesobuthus eupeus",
    family: mockFamily,
    type: "SCORPION",
    hasRedFlag: false,
    hasMildVenom: true,
    venomous: true,
    image: "https://api.herpi.ge/uploads/2141.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile5: NearbyReptileModel = .init(
    id: 4,
    name: "Grass Snake",
    scientificName: "Natrix Natrix",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: false,
    venomous: true,
    image: "https://api.herpi.ge/uploads/file",
    addedBy: mockAddedBy
)

public let mockNearbyReptile6: NearbyReptileModel = .init(
    id: 5,
    name: "Smooth snake",
    scientificName: "Coronella austriaca",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: true,
    venomous: false,
    image: "https://api.herpi.ge/uploads/2182.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile7: NearbyReptileModel = .init(
    id: 6,
    name: "Schmidt's whip snake",
    scientificName: "Dolichophis schmidti",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: false,
    hasMildVenom: false,
    venomous: false,
    image: "https://api.herpi.ge/uploads/1899.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile8: NearbyReptileModel = .init(
    id: 7,
    name: "Lesser Asian Scorpion",
    scientificName: "Mesobuthus eupeus",
    family: mockFamily,
    type: "SCORPION",
    hasRedFlag: false,
    hasMildVenom: true,
    venomous: true,
    image: "https://api.herpi.ge/uploads/2141.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptile9: NearbyReptileModel = .init(
    id: 8,
    name: "Lesser Asian Scorpion",
    scientificName: "Mesobuthus eupeus",
    family: mockFamily,
    type: "SCORPION",
    hasRedFlag: false,
    hasMildVenom: true,
    venomous: true,
    image: "https://api.herpi.ge/uploads/2141.jpg",
    addedBy: mockAddedBy
)

public let mockNearbyReptiles: [NearbyReptileModel] = [
    mockNearbyReptile1, mockNearbyReptile2, mockNearbyReptile3, mockNearbyReptile4,
    mockNearbyReptile5, mockNearbyReptile6, mockNearbyReptile7, mockNearbyReptile8
]
