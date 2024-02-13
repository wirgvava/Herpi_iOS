//
//  CoverageModel.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import Foundation

struct CoverageModelElement: Codable {
    let id, area: String?
    let coordinates: [Coordinate]
}

struct Coordinate: Codable {
    var lat: Double = 0.0
    var lng: Double = 0.0
}

typealias CoverageModel = [CoverageModelElement]

