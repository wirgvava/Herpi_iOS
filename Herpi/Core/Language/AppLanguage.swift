//
//  AppLanguage.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 16.01.26.
//

import Foundation

final class AppLanguage {
        
    enum Language: String {
        case en
        case ka
    }
    
    static var currentLanguage: String {
        UserDefaultsManager.shared.get(forKey: .appLanguage)
    }
    
    static func setLanguage(_ language: Language) {
        UserDefaultsManager.shared.set(language.rawValue, forKey: .appLanguage)
    }
}
