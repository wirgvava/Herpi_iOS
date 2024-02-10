//
//  ApiType.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//

import Foundation
import Moya

enum ApiType: TargetType {
    case categories
    case reptiles
    case nearby(lat: Double, lng: Double)
    
    var baseURL: URL {
        return URL(string: "https://api.herpi.ge")!
    }
    
    var path: String {
        switch self {
        case .categories: 
            return "/api/v1/reptiles/categories"
        case .reptiles:
            return "/api/v1/reptiles"
        case .nearby:
            return "/api/v1/reptiles/nearby"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .categories:
            return .get
        case .reptiles:
            return .get
        case .nearby:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .categories:
            return .requestPlain
        case .reptiles:
            return .requestPlain
        case .nearby(let lat, let lng):
            return .requestParameters(parameters: ["lat": lat, 
                                                   "lng": lng],
                                      encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Accept-Language" : "ka"]
    }
}
