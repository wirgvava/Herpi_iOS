//
//  String+Extensions.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 16.01.26.
//


import Foundation

extension String {
    
    func localized(using tableName: String? = nil) -> String {
        if let rp = Bundle.main.path(forResource: AppLanguage.currentLanguage.rawValue, ofType: "lproj"),
            let value = Bundle(path: rp)?.localizedString(forKey: self, value: nil, table: tableName) {
            return value
        }
        return self
    }
}
