//
//  CoverageModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct CoverageModelElement: Codable, Sendable, Identifiable, Equatable {
    public var id: String
    public var area: String
    public var coordinates: [Coordinate]
    
    public init(
        id: String = .empty,
        area: String = .empty,
        coordinates: [Coordinate] = [Coordinate]()
    ) {
        self.id = id
        self.area = area
        self.coordinates = coordinates
    }
}

public typealias CoverageModel = [CoverageModelElement]

// MARK: - Mock
public let mockCoverage: CoverageModel = [
    .init(
        id: "8d5492b0-7b27-4b07-b561-ac04c8e0c499",
        area: "-",
        coordinates: [
            .init(lat: 41.21324353631091, lng: 43.64078761484099),
            .init(lat: 41.199812176012074, lng: 43.66962672616911),
            .init(lat: 41.184311026820815, lng: 43.64628077890349),
            .init(lat: 41.201878718584936, lng: 43.62568141366911)
        ]
    ),
    .init(
        id: "f92c3fe9-feaf-4ea7-ad3f-bc148139df20",
        area: "-",
        coordinates: [
            .init(lat: 41.04949546861698, lng: 43.79601263676486),
            .init(lat: 41.140570172946425, lng: 43.76305365238986),
            .init(lat: 41.157115642858706, lng: 43.90587591801486),
            .init(lat: 41.07020535212948, lng: 43.90038275395236)
        ]
    ),
]
