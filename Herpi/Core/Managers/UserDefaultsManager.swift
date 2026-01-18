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
    }
    
    // - Strings
    func set(_ value: String, forKey key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func get(forKey key: Keys) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? .empty
    }
}
