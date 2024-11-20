//
//  ArticleServicesFactory.swift
//  NYTimes
//
//  Created by MAC918580 on 20/11/2024.
//

import Foundation

struct ArticleServicesFactory {
    static func create(shouldThrowError: Bool = false) -> MostViewedArticlesNetworkServiceProtocol {
        let environment = ProcessInfo.processInfo.environment["ENV"]
        return environment == "TEST" ? MostViewedArticlesNetworkService() : MockMostViewedArticlesNetworkService(shouldThrowError: false)
    }
}
