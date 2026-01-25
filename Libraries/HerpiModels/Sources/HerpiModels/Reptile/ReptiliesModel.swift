//
//  ReptiliesModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct ReptileModel: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var name: String
    public var scientificName: String
    public var family: Family
    public var type: String
    public var hasRedFlag: Bool
    public var hasMildVenom: Bool
    public var venomous: Bool
    public var transparentThumbnail: String
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
        transparentThumbnail: String = .empty,
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
        self.transparentThumbnail = transparentThumbnail
        self.addedBy = addedBy
    }
}

public typealias ReptilesModel = [ReptileModel]

// MARK: - Mock
public let mockReptiles: ReptilesModel = [
    .init(
        id: 0,
        name: "Darevsky's Viper",
        scientificName: "Vipera Darevskii",
        family: mockFamily,
        type: "SNAKE",
        hasRedFlag: true,
        hasMildVenom: false,
        venomous: true,
        transparentThumbnail: "https://api.herpi.ge/uploads/1000_F_23980448_o9L9OagUTa3hH5rIMpRjbIE63kGKVTyA.png",
        addedBy: mockAddedBy
    ),
    .init(
        id: 1,
        name: "Darevsky's Viper",
        scientificName: "Vipera Darevskii",
        family: mockFamily,
        type: "SNAKE",
        hasRedFlag: true,
        hasMildVenom: false,
        venomous: false,
        transparentThumbnail: "https://api.herpi.ge/uploads/1000_F_23980448_o9L9OagUTa3hH5rIMpRjbIE63kGKVTyA.png",
        addedBy: mockAddedBy
    ),
    .init(
        id: 2,
        name: "Darevsky's Viper",
        scientificName: "Vipera Darevskii",
        family: mockFamily,
        type: "SNAKE",
        hasRedFlag: true,
        hasMildVenom: true,
        venomous: true,
        transparentThumbnail: "https://api.herpi.ge/uploads/1000_F_23980448_o9L9OagUTa3hH5rIMpRjbIE63kGKVTyA.png",
        addedBy: mockAddedBy
    ),
    .init(
        id: 3,
        name: "Darevsky's Viper",
        scientificName: "Vipera Darevskii",
        family: mockFamily,
        type: "SNAKE",
        hasRedFlag: false,
        hasMildVenom: false,
        venomous: false,
        transparentThumbnail: "https://api.herpi.ge/uploads/1000_F_23980448_o9L9OagUTa3hH5rIMpRjbIE63kGKVTyA.png",
        addedBy: mockAddedBy
    )
]
