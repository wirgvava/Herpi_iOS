//
//  String+Extensions.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 19.02.24.
//

import Foundation

extension String {
    var localized: String {
        let currentLangueage = UserDefaultsManager.shared.get(data: .language)
        if let rp = Bundle.main.path(forResource: currentLangueage, ofType: "lproj"),
            let value = Bundle(path: rp)?.localizedString(forKey: self, value: nil, table: nil) {
            return value
        }
        return self
    }
}
