//
//  HandleResponseMethods.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//
import Foundation
import Moya

func handleResponse<T: Codable>(result: Result<Response, MoyaError>, key: CacheForKey, completion: @escaping (T?, Error?) -> ()) {
    switch result {
    case .success(let response):
        do {
            let decodedResponse = try response.map(T.self)
            CacheManager.shared.updateCache(data: decodedResponse, forKey: key)
            completion(decodedResponse, nil)
        } catch {
            completion(nil, error)
        }
    case .failure(let error):
        completion(nil, error)
    }
}
