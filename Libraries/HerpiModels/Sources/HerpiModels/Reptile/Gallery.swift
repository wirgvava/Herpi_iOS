//
//  Gallery.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct Gallery: Codable, Sendable, Identifiable, Equatable {
    public var id: Int
    public var url: String
    public var credits: [String]
    public var author: AddedBy
    
    public init(
        id: Int = .zero,
        url: String = .empty,
        credits: [String] = [],
        author: AddedBy = AddedBy()
    ) {
        self.id = id
        self.url = url
        self.credits = credits
        self.author = author
    }
}

// MARK: - Mock
public let mockGallery_1: Gallery = .init(
    id: 0,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)

public let mockGallery_2: Gallery = .init(
    id: 1,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)

public let mockGallery_3: Gallery = .init(
    id: 2,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)

public let mockGallery_4: Gallery = .init(
    id: 3,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)

public let mockGallery_5: Gallery = .init(
    id: 4,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)
