//
//  CategoryModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation

struct CategoryModel: Codable {
    let id, title, titleTurned: String?
    let iconURL: String?

    enum CodingKeys: String, CodingKey {
        case id, title, titleTurned
        case iconURL = "iconUrl"
    }
}

typealias CategoriesModel = [CategoryModel]
