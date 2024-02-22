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
    case detailed
    case team
    case faq
}

class CacheManager {
    
    static let shared = CacheManager()
    private var cachedCategories: CategoriesModel?
    private var cachedReptiles: ReptiliesModel?
    private var cachedNearbyReptiles: NearbyReptilesModel?
    private var cachedDetailedReptiles: DetailedInfoResponseModel?
    private var cachedTeamData: TeamModel?
    private var cachedFaqData: FAQModel?

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
        case .detailed:
            if let detailedReptileData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: detailedReptileData, forKey: .detailed)
                cachedDetailedReptiles = data as? DetailedInfoResponseModel
            }
        case .team:
            if let teamData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: teamData, forKey: .team)
                cachedTeamData = data as? TeamModel
            }
        case .faq:
            if let faqData = try? JSONEncoder().encode(data) {
                UserDefaultsManager.shared.save(value: faqData, forKey: .faq)
                cachedFaqData = data as? FAQModel
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
        case .detailed:
            if let data = UserDefaultsManager.shared.get(data: .detailed) {
                return try? JSONDecoder().decode(DetailedInfoResponseModel.self, from: data) as? T
            }
        case .team:
            if let data = UserDefaultsManager.shared.get(data: .team) {
                return try? JSONDecoder().decode(TeamModel.self, from: data) as? T
            }
        case .faq:
            if let data = UserDefaultsManager.shared.get(data: .faq) {
                return try? JSONDecoder().decode(FAQModel.self, from: data) as? T
            }
        }
        return nil
    }
}
