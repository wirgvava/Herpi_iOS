//
//  HandleResponseMethods.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//
import Foundation
import Moya

func handleResponseWithCache<T: Codable>(result: Result<Response, MoyaError>, key: CacheForKey, completion: @escaping (T?, Error?) -> ()) {
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

func handleResponse<ModelType: Decodable>(result: Result<Response, MoyaError>, ofType: ModelType.Type? = nil, completion: ((_ model: ModelType?, _ error: Error?) -> Void)) {
    switch result {
    case let .success(moyaResponse):
        let data = moyaResponse.data
        let statusCode = moyaResponse.statusCode
     
        if statusCode == 200 {
            var model: ModelType? = nil
            do {
                model = try JSONDecoder().decode(ModelType.self, from: data)
            } catch {
                print("JSON decode error: \(error).")
            }
            completion(model, nil)
        } else {
            print("statusCode: \(statusCode)")
        }
    case let .failure(error):
        completion(nil, error)
    }
}
