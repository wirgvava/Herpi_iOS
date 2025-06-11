//
//  Gallery.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct Gallery: Codable, Sendable, Identifiable {
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
public let mockGallery: Gallery = .init(
    id: 0,
    url: "https://api.herpi.ge/uploads/2171.jpg",
    credits: ["Konstantine Tsirgvava"],
    author: mockAddedBy
)
