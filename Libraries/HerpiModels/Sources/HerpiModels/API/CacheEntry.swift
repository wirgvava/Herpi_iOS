//
//  CacheEntry.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation

public struct CacheEntry: Codable, Sendable {
    public let data: Data
    public let cachedAt: Date
    public let dataStateTimestamp: Int
    
    public init(data: Data, dataStateTimestamp: Int) {
        self.data = data
        self.cachedAt = Date()
        self.dataStateTimestamp = dataStateTimestamp
    }
}
