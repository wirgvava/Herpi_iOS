//
//  NearbyReptileModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation

struct NearbyReptileModel: Codable {
    let id: Int?
    let name, scientificName: String?
    let family: Family?
    let type: String?
    let hasRedFlag, hasMildVenom, venomous: Bool?
    let image: String?
    let addedBy: AddedBy?
}

typealias NearbyReptilesModel = [NearbyReptileModel]
