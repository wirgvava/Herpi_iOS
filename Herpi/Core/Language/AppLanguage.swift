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
    
    @MainActor static var currentLanguage = UserDefaultsManager.appLanguage
    
    @MainActor static func setLanguage(_ language: Language) {
        UserDefaultsManager.appLanguage = language.rawValue
    }
}
