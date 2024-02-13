//
//  CacheManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 10.02.24.
//

import Foundation

enum CacheForKey: String {
    case categories
    case reptilies
    case nearby
    case detailedReptile
}

class CacheManager {
    
    static let shared = CacheManager()
    private var cachedCategories: CategoriesModel?
    private var cachedReptiles: ReptiliesModel?
    private var cachedNearbyReptiles: NearbyReptilesModel?
    private var cachedDetailedReptiles: DetailedInfoResponseModel?

    func updateCache<T: Codable>(data: T, forKey key: CacheForKey) {
        switch key {
        case .categories:
            if let categoriesData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: categoriesData, forKey: .categories)
                cachedCategories = data as? CategoriesModel
            }
        case .reptilies:
            if let reptilesData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: reptilesData, forKey: .reptilies)
                cachedReptiles = data as? ReptiliesModel
            }
        case .nearby:
            if let nearbyReptilesData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: nearbyReptilesData, forKey: .nearby)
                cachedNearbyReptiles = data as? NearbyReptilesModel
            }
        case .detailedReptile:
            if let detailedReptilesData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: detailedReptilesData, forKey: .detailedReptile)
                cachedDetailedReptiles = data as? DetailedInfoResponseModel
            }
        }
        UserDefaultsManager.shared.synchronize()
    }

    func retrieveData<T: Codable>(forKey key: CacheForKey) -> T? {
        switch key {
        case .categories:
            if let data = UserDefaultsManager.shared.get(data: .categories) {
                return try? JSONDecoder().decode(CategoriesModel.self, from: data) as? T
            }
        case .reptilies:
            if let data = UserDefaultsManager.shared.get(data: .reptilies) {
                return try? JSONDecoder().decode(ReptiliesModel.self, from: data) as? T
            }
        case .nearby:
            if let data = UserDefaultsManager.shared.get(data: .nearby) {
                return try? JSONDecoder().decode(NearbyReptilesModel.self, from: data) as? T
            }
        case .detailedReptile:
            if let data = UserDefaultsManager.shared.get(data: .detailedReptile) {
                return try? JSONDecoder().decode(DetailedInfoResponseModel.self, from: data) as? T
            }
        }
        return nil
    }
}
