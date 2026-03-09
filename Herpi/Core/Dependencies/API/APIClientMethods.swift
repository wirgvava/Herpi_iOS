//
//  APIClientMethods.swift
//  Herpi
//
//  Created by Konstantine Tsirgvava on 09.03.26.
//

import Foundation
import HerpiFoundation
import HerpiModels

extension APIClient {
    
    // MARK: Categories
    func fetchCategories() async throws -> CategoriesModel {
        let data = try await request(.categories)
        return try JSONDecoder.apiDecoder.decode(CategoriesModel.self, from: data)
    }
    
    // MARK: Reptiles
    func fetchReptiles() async throws -> ReptilesModel {
        let data = try await request(.reptiles)
        return try JSONDecoder.apiDecoder.decode(ReptilesModel.self, from: data)
    }
    
    // MARK: Nearby Reptiles
    func fetchNearbyReptiles(lat: Double, lng: Double) async throws -> NearbyReptilesModel {
        let data = try await request(.nearby(lat: lat, lng: lng))
        return try JSONDecoder.apiDecoder.decode(NearbyReptilesModel.self, from: data)
    }
    
    // MARK: Search
    func searchReptiles(query: String) async throws -> SearchResponseModel {
        let data = try await request(.search(query: query))
        return try JSONDecoder.apiDecoder.decode(SearchResponseModel.self, from: data)
    }
    
    // MARK: Detailed Info
    func fetchDetailedInfo(reptileId: Int) async throws -> DetailedInfoModel {
        let data = try await request(.detailedInfo(reptileId: reptileId))
        return try JSONDecoder.apiDecoder.decode(DetailedInfoModel.self, from: data)
    }
    
    // MARK: Coverage
    func fetchCoverage(reptileId: Int) async throws -> CoverageModel {
        let data = try await request(.coverage(reptileId: reptileId))
        return try JSONDecoder.apiDecoder.decode(CoverageModel.self, from: data)
    }
    
    // MARK: Team
    func fetchTeam() async throws -> TeamModel {
        let data = try await request(.team)
        return try JSONDecoder.apiDecoder.decode(TeamModel.self, from: data)
    }
    
    // MARK: FAQ
    func fetchFAQ() async throws -> FAQModel {
        let data = try await request(.faq)
        return try JSONDecoder.apiDecoder.decode(FAQModel.self, from: data)
    }
    
    // MARK: Data State
    func fetchDataState() async throws -> DataStateModel {
        let data = try await request(.dataState)
        return try JSONDecoder.apiDecoder.decode(DataStateModel.self, from: data)
    }
    
    // Fetch dataState directly from network (for sync checks)
    func fetchDataStateFromNetwork() async throws -> DataStateModel {
        let data = try await requestIgnoringCache(.dataState)
        return try JSONDecoder.apiDecoder.decode(DataStateModel.self, from: data)
    }
}
