//
//  ApiManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 10.02.24.
//

import Moya
import Reachability

class ApiManager {
    
    fileprivate let serverProvider = MoyaProvider<ApiType>()
    fileprivate let reachability = try! Reachability()
    
    func getCategories(completion: @escaping (CategoriesModel?,Error?) -> ()){
        if reachability.connection != .unavailable {
            serverProvider.request(.categories) { result in
                handleResponse(result: result, key: .categories, completion: completion)
            }
        } else {
            if let cachedData: CategoriesModel = CacheManager.shared.retrieveData(forKey: .categories) {
                completion(cachedData, nil)
            }
        }
    }
    
    func getReptilesList(completion: @escaping (ReptiliesModel?, Error?) -> ()){
        if reachability.connection != .unavailable {
            serverProvider.request(.reptiles) { result in
                handleResponse(result: result, key: .reptilies, completion: completion)
            }
        } else {
            if let cachedData: ReptiliesModel = CacheManager.shared.retrieveData(forKey: .reptilies) {
                completion(cachedData, nil)
            }
        }
    }
    
    func getNearbyReptileList(lat: Double, lng: Double, completion: @escaping (NearbyReptilesModel?, Error?) -> ()){
        if reachability.connection != .unavailable {
            serverProvider.request(.nearby(lat: lat, lng: lng)) { result in
                handleResponse(result: result, key: .nearby, completion: completion)
            }
        } else {
            if let cachedData: NearbyReptilesModel = CacheManager.shared.retrieveData(forKey: .nearby) {
                completion(cachedData, nil)
            }
        }
    }
}
