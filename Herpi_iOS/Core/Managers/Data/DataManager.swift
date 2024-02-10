//
//  DataManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 10.02.24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    // - Main page data
    var categories: [CategoryModel] = []
    var nearbyReptiles: [NearbyReptileModel] = []
    var reptiles: [ReptileModel] = []
    
}
