//
//  SearchResponseModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct SearchResponseModel: Codable, Sendable {
    public var data: [SearchedData]?
    
    public init(data: [SearchedData]? = []) {
        self.data = data
    }
}

public struct SearchedData: Codable, Sendable, Identifiable {
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
    public var views: Int
    
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
        addedBy: AddedBy = AddedBy(),
        views: Int = .zero
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
        self.views = views
    }
}

// MARK: - Mock
public let mockSearchedData: SearchedData = .init(
    id: 0,
    name: "Darevsky's Viper",
    scientificName: "Vipera Darevskii",
    family: mockFamily,
    type: "SNAKE",
    hasRedFlag: true,
    hasMildVenom: false,
    venomous: true,
    image: "https://api.herpi.ge/uploads/2141.jpg",
    addedBy: mockAddedBy,
    views: 1231
)
