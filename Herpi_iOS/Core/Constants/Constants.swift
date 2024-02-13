//
//  Constants.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 13.02.24.
//

import Foundation

class Constants {
    
    // Default locations
    static let lat = 41.69340737013904
    static let lng = 44.80145250589819
    
    // ShareURL
    static func shareURL(for reptileId: Int) -> String {
        return "https://herpi.ge/reptiles/\(reptileId)/details"
    }

}
