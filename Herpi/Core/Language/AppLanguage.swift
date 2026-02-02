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
        case ka = "ka-GE"
    }
    
    static var currentLanguage: Language {
        AppLanguage.Language(rawValue: UserDefaultsManager.shared.get(forKey: .appLanguage)) ?? .ka
    }
    
    static func setLanguage(_ language: Language) {
        UserDefaultsManager.shared.set(language.rawValue, forKey: .appLanguage)
    }
}
