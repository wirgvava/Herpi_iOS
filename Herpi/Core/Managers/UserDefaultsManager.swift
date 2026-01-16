//
//  UserDefaultsManager.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 16.01.26.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    let storage: UserDefaults
    
    init(_ key: String, defaultValue: T, storage: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    var wrappedValue: T {
        get {
            return storage.object(forKey: key) as? T ?? defaultValue
        }
        set {
            storage.set(newValue, forKey: key)
        }
    }
}

@MainActor 
final class UserDefaultsManager {
    
    @UserDefault("appLanguage", defaultValue: AppLanguage.Language.en.rawValue)
    static var appLanguage: String
    
}
