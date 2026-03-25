//
//  UserDefaultsManager.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 16.01.26.
//

import Foundation
import HerpiFoundation

final class UserDefaultsManager: Sendable {
    
    static let shared = UserDefaultsManager()
  
    enum Keys: String {
        case appLanguage
        case detailPageViewCount
        case hasRequestedReview
    }
    
    // - Strings
    func set(_ value: String, forKey key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func get(forKey key: Keys) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? .empty
    }
    
    // - Integers
    func set(_ value: Int, forKey key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getInt(forKey key: Keys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    // - Booleans
    func set(_ value: Bool, forKey key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(forKey key: Keys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
