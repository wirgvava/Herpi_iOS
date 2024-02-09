//
//  UserDefaultsManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 09.02.24.
//

import Foundation

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()
    
    enum Data: String {
        case firstLoginSelected
    }
    
    func save(value: Bool, data: Data) {
        UserDefaults.standard.set(value, forKey: data.rawValue)
    }
    
    func getBool(data: Data) -> Bool {
        return (UserDefaults.standard.object(forKey: data.rawValue) as? Bool) ?? false
    }
}
