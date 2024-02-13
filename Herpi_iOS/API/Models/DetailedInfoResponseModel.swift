//
//  DetailedInfoResponseModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import Foundation

struct DetailedInfoResponseModel: Codable {
    let id: Int?
    let name, scientificName: String?
    let family: Family?
    let genus, type, description: String?
    let hasRedFlag, hasMildVenom, venomous: Bool?
    let image: String?
    let gallery: [Gallery]?
    let addedBy: AddedBy?
    let status: String?
    let views, createdAt, publishedAt: Int?
}

struct Gallery: Codable {
    let id: Int?
    let url: String?
    let credits: [String]?
    let author: AddedBy?
}
