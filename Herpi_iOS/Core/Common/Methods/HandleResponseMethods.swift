//
//  HandleResponseMethods.swift
//  Herpi_iOS
//
//  Created by Konstantine Tsirgvava on 04.02.24.
//
import Foundation
import Moya

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
            completion(nil, data as? Error)
        }
    case let .failure(error):
        let error = "\(error.localizedDescription)"
        completion(nil, error as? Error)
    }
}
