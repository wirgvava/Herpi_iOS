//
//  SyncState.swift
//  HerpiModels
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation

public enum CacheConstants {
    public static let dataStateCheckInterval: TimeInterval = 3 * 24 * 60 * 60 // 3 days in seconds
}

public struct SyncState: Codable, Sendable {
    public var lastSyncDate: Date
    public var lastDataStateTimestamp: Int
    
    public var shouldCheckDataState: Bool {
        Date().timeIntervalSince(lastSyncDate) > CacheConstants.dataStateCheckInterval
    }
    
    public init(lastSyncDate: Date, lastDataStateTimestamp: Int) {
        self.lastSyncDate = lastSyncDate
        self.lastDataStateTimestamp = lastDataStateTimestamp
    }
}
