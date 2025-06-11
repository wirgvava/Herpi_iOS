//
//  ReptiliesModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct ReptileModel: Codable, Sendable, Identifiable {
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

public typealias ReptiliesModel = [ReptileModel]

// MARK: - Mock
public let mockReptiles: ReptiliesModel = [
    .init(
        id: 0,
        name: "Darevsky's Viper",
        scientificName: "Vipera Darevskii",
        family: mockFamily,
        type: "SNAKE",
        hasRedFlag: true,
        hasMildVenom: false,
        venomous: true,
        transparentThumbnail: "https://herpi-main-bucket.s3.amazonaws.com/thumbnail/2201",
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
        transparentThumbnail: "https://herpi-main-bucket.s3.amazonaws.com/thumbnail/2201",
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
        transparentThumbnail: "https://herpi-main-bucket.s3.amazonaws.com/thumbnail/2201",
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
        transparentThumbnail: "https://herpi-main-bucket.s3.amazonaws.com/thumbnail/2201",
        addedBy: mockAddedBy
    )
]
