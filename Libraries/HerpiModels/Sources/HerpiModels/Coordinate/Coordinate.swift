//
//  Coordinate.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct Coordinate: Codable, Sendable, Equatable {
    public var lat: Double
    public var lng: Double
    
    public init(lat: Double = .zero, lng: Double = .zero) {
        self.lat = lat
        self.lng = lng
    }
}

// MARK: - Mock
public let mockCoordinates = Coordinate(lat: 41.724720, lng: 44.776237)
