//
//  SearchResponseModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 12.02.24.
//

import Foundation

struct SearchResponseModel: Codable {
    let data: [SearchedData]?
}

struct SearchedData: Codable {
    let id: Int?
    let name, scientificName: String?
    let family: Family?
    let type: String?
    let hasRedFlag, hasMildVenom, venomous: Bool?
    let image: String?
    let addedBy: AddedBy?
    let views: Int?
}
