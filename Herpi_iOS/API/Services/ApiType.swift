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
    case search(query: String)
    case detailedInfo(reptileId: Int)
    case coverage(reptileId: Int)
    case team
    case faq
    
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
        case .search:
            return "/api/v1/reptiles/search"
        case .detailedInfo(let reptileId):
            return "/api/v1/reptiles/\(reptileId)"
        case .coverage(let reptileId):
            return "/api/v1/reptiles/\(reptileId)/coverage"
        case .team:
            return "/api/v1/team"
        case .faq:
            return "/api/v1/faq"
            
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
        case .search:
            return .get
        case .detailedInfo:
            return .get
        case .coverage:
            return .get
        case .team:
            return .get
        case .faq:
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
            return .requestParameters(parameters: ["lat": lat, "lng": lng],
                                      encoding: URLEncoding.default)
        case .search(let query):
            return .requestParameters(parameters: ["query" : query], encoding: URLEncoding.default)
        case .detailedInfo:
            return .requestPlain
        case .coverage:
            return .requestPlain
        case .team:
            return .requestPlain
        case .faq:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let language = UserDefaultsManager.shared.get(data: .language) ?? "ka"
        return ["Accept-Language" : language]
    }
}
