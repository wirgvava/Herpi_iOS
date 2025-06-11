//
//  DataStateModel.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 10.06.25.
//

import HerpiFoundation

public struct DataStateModel: Codable, Sendable {
    public var timestamp: Int
    
    public init(timestamp: Int = .zero) {
        self.timestamp = timestamp
    }
}
