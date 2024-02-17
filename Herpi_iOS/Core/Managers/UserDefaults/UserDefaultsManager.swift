//
//  UserDefaultsManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 09.02.24.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()
    
    enum Key: String {
        case firstLoginSelected
        // Cached data
        case categoriesData
        case reptilesData
        case nearbyReptilesData
    }
    
    // - Save
    func save(value: Bool, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    // - Get
    func getBool(data: Key) -> Bool {
        return (UserDefaults.standard.object(forKey: data.rawValue) as? Bool) ?? false
    }
    
    // - Cache
    func save(value: Data, forKey key: CacheForKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func get(data: CacheForKey) -> Data? {
        return UserDefaults.standard.data(forKey: data.rawValue)
    }
    
    // - Synchronize
    func synchronize(){
        UserDefaults.standard.synchronize()
    }
}

// MARK: - Language
extension UserDefaultsManager {
    
    enum Language: String {
        case ka
        case en
    }
    
    func save(value: Language, forKey key: Constant){
        UserDefaults.standard.setValue(value.rawValue, forKey: key.rawValue)
    }
    
    func get(data: Constant) -> String? {
        return UserDefaults.standard.string(forKey: data.rawValue)
    }
    
    enum Constant: String {
        case language
    }
}
