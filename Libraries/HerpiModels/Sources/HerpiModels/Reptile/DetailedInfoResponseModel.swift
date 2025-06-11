//
//  DetailedInfoResponseModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct DetailedInfoResponseModel: Codable, Sendable, Identifiable {
    public var id: Int
    public var name: String
    public var scientificName: String
    public var family: Family
    public var genus: String
    public var type: String
    public var description: String
    public var hasRedFlag: Bool
    public var hasMildVenom: Bool
    public var venomous: Bool
    public var image: String
    public var gallery: [Gallery]
    public var addedBy: AddedBy
    public var status: String
    public var views: Int
    public var createdAt: Int
    public var publishedAt: Int
    
    public init(
        id: Int = .zero,
        name: String = .empty,
        scientificName: String = .empty,
        family: Family = Family(),
        genus: String = .empty,
        type: String = .empty,
        description: String = .empty,
        hasRedFlag: Bool = false,
        hasMildVenom: Bool = false,
        venomous: Bool = false,
        image: String = .empty,
        gallery: [Gallery] = [],
        addedBy: AddedBy = AddedBy(),
        status: String = .empty,
        views: Int = .zero,
        createdAt: Int = .zero,
        publishedAt: Int = .zero
    ) {
        self.id = id
        self.name = name
        self.scientificName = scientificName
        self.family = family
        self.genus = genus
        self.type = type
        self.description = description
        self.hasRedFlag = hasRedFlag
        self.hasMildVenom = hasMildVenom
        self.venomous = venomous
        self.image = image
        self.gallery = gallery
        self.addedBy = addedBy
        self.status = status
        self.views = views
        self.createdAt = createdAt
        self.publishedAt = publishedAt
    }
}

public typealias DetailedInfoResponseModels = [DetailedInfoResponseModel]

// MARK: - Mock
public let mockDetailedInfo: DetailedInfoResponseModel = .init(
    id: 1914,
    name: "Darevsky's Viper",
    scientificName: "Vipera Darevskii",
    family: mockFamily,
    genus: "Vipera",
    type: "SNAKE",
    description: "The Darevsky's viper is a venomous snake that belongs to the family Viperidae. Named in honour of the famous herpetologist, Ilya Darevsky, who was the first to discover a specimen of this species in Armenia. The length of male specimens varies from about 25-30 cm, while that of females - up to 40-45 cm. It has a wide head, the side of the snout is cut off, the front side is a bit rounded. It is yellowish-grey or yellowish-brown in colour. There is a brown zig-zag stripe along the back of the body, on the sides - dark faint spots on one row. The abdomen is blackish. For a long time, only one population of this species was known in the north-western part of Armenia and in Georgia, in particular, in the eastern part of the Javakheti Range. It feeds on rodents, locusts and rock lizards. Due to its small number, it is listed in the Red Book of the International Union for Conservation of Nature (IUCN) as Critically Endangered (CR).",
    hasRedFlag: true,
    hasMildVenom: false,
    venomous: true,
    image: "https://api.herpi.ge/uploads/1749048121588.jpg",
    gallery: [mockGallery, mockGallery, mockGallery, mockGallery],
    addedBy: mockAddedBy,
    status: "PUBLISHED",
    views: 10237,
    createdAt: 1652012660181,
    publishedAt: 1652013036929
)
