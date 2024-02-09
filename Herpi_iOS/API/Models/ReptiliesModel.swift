//
//  ReptiliesModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation

struct ReptileModel: Codable {
    let id: Int?
    let name, scientificName: String?
    let family: Family?
    let type: String?
    let hasRedFlag, hasMildVenom, venomous: Bool?
    let image: String?
    let addedBy: AddedBy?
}

// MARK: - AddedBy
struct AddedBy: Codable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let avatar: String?
}

// MARK: - Family
struct Family: Codable {
    let id: Int?
    let name: String?
    let image: String?
}

typealias ReptiliesModel = [ReptileModel]
