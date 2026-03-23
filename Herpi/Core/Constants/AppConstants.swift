//
//  AppConstants.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 18.01.26.
//


import Foundation

struct AppConstants {
    
    // Default locations
    static let lat = 41.69340737013904
    static let lng = 44.80145250589819
    
    static func shareURL(for reptileId: Int) -> String {
        return "https://api.herpi.ge/reptiles/\(reptileId)/details/preview"
    }
    
    static let chatUrl = "https://m.me/reptiledb"
    static let contactUrl = "https://herpi.ge/contact"
}
