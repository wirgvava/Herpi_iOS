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
    
//  MARK: - Main Page Requests
    func getCategories(completion: @escaping (CategoriesModel?,Error?) -> ()){
        if reachability.connection != .unavailable {
            serverProvider.request(.categories) { result in
                handleResponseWithCache(result: result, key: .categories, completion: completion)
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
                handleResponseWithCache(result: result, key: .reptilies, completion: completion)
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
                handleResponseWithCache(result: result, key: .nearby, completion: completion)
            }
        } else {
            if let cachedData: NearbyReptilesModel = CacheManager.shared.retrieveData(forKey: .nearby) {
                completion(cachedData, nil)
            }
        }
    }
}

// MARK: - Search Requests
extension ApiManager {
    func getSearchResult(with query: String, completion: @escaping (SearchResponseModel?, Error?) -> ()){
        serverProvider.request(.search(query: query)) { result in
            handleResponse(result: result, completion: completion)
        }
    }
}

// MARK: - Detailed Info Requests
extension ApiManager {
    func getDetailedInfo(for reptileId: Int, completion: @escaping (DetailedInfoResponseModel?, Error?) -> ()){
        if reachability.connection != .unavailable {
            serverProvider.request(.detailedInfo(reptileId: reptileId)) { result in
                handleResponseWithCache(result: result, key: .detailedReptile, completion: completion)
            }
        } else {
            if let cachedData: DetailedInfoResponseModel = CacheManager.shared.retrieveData(forKey: .detailedReptile) {
                completion(cachedData, nil)
            }
        }
    }
    
    func getCoverageInfo(for reptileId: Int, completion: @escaping (CoverageModel?, Error?) -> ()){
        serverProvider.request(.coverage(reptileId: reptileId)) { result in
            handleResponse(result: result, completion: completion)
        }
    }
}
