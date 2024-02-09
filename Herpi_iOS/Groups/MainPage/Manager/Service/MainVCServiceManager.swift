//
//  MainVCServiceManager.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation
import Moya

class MainVCServiceManager {
    
    fileprivate let serverProvider = MoyaProvider<ApiType>()
    
    func getCategories(completion: @escaping (CategoriesModel?,Error?) -> ()){
        serverProvider.request(.categories){ result in
            handleResponse(result: result, completion: completion)
        }
    }
    
    func getReptiliesList(completion: @escaping (ReptiliesModel?, Error?) -> ()){
        serverProvider.request(.reptilies) { result in
            handleResponse(result: result, completion: completion)
        }
    }
    
    func getNearbyReptileList(lat: Double, lng: Double, completion: @escaping (NearbyReptilesModel?, Error?) -> ()){
        serverProvider.request(.nearby(lat: lat, lng: lng)) { result in
            handleResponse(result: result, completion: completion)
        }
    }
}
