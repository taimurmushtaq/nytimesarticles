//
//  MostViewedArticlesNetworkService.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import Foundation

protocol MostViewedArticlesNetworkServiceProtocol {
    func getArticles(for section: CoreQueryParam, period: Articles.Periods) async throws -> Articles.ResponseModel
}

class MostViewedArticlesNetworkService: MostViewedArticlesNetworkServiceProtocol {
    let httpClient = CoreNetworkClient()
    
    func getArticles(for section: CoreQueryParam, period: Articles.Periods) async throws -> Articles.ResponseModel {
        guard let url = Articles.Urls.mostViewed(section.rawValue, period.rawValue).url else {
            throw CoreNetworkError.badRequest
        }
        
        let queryItem: URLQueryItem = .init(name: CoreQueryParam.apiKey.rawValue, value: CoreConstants.apiKey)
        
        let networkResource = CoreNetworkResource(
            method: .get([queryItem]),
            url: url,
            modelType: Articles.ResponseModel.self
        )
        
        return try await httpClient.load(networkResource)
    }
}
