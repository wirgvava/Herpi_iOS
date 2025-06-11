//
//  CategoryModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct CategoryModel: Codable, Sendable, Identifiable {
    public var id: String
    public var title: String
    public var titleTurned: String
    public var iconUrl: String

    public init(
        id: String = .empty,
        title: String = .empty,
        titleTurned: String = .empty,
        iconUrl: String = .empty
    ) {
        self.id = id
        self.title = title
        self.titleTurned = titleTurned
        self.iconUrl = iconUrl
    }
}

public typealias CategoriesModel = [CategoryModel]

// MARK: - Mock
public let mockCategories: CategoriesModel = [
    .init(id: "UNCATEGORIZED", title: "Uncategorized", titleTurned: "All", iconUrl: "https://herpi-main-bucket.s3.amazonaws.com/icons/png/Group+44.png"),
    .init(id: "SNAKE", title: "Snake", titleTurned: "Snakes", iconUrl: "https://herpi-main-bucket.s3.amazonaws.com/icons/png/snake.png"),
    .init(id: "LIZARD", title: "Lizard", titleTurned: "Lizards", iconUrl: "https://herpi-main-bucket.s3.amazonaws.com/icons/png/lizard_outline.png"),
    .init(id: "SCORPION", title: "Scorpion", titleTurned: "Scorpions", iconUrl: "https://herpi-main-bucket.s3.amazonaws.com/icons/png/scorpion.png")
]
