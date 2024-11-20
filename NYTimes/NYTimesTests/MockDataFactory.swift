//
//  MockDataFactory.swift
//  NYTimesTests
//
//  Created by Taimur on 18/11/2024.
//

import XCTest
@testable import NYTimes

class MockDataFactory {
    static var articleResponseModel: Articles.ResponseModel {
        return try! Bundle.main.decode(Articles.ResponseModel.self, from: "Articles.json")
    }

    static var articleModel: Articles.Model {
        return articleResponseModel.results.first!
    }
}

class MockMostViewedArticlesNetworkService: MostViewedArticlesNetworkServiceProtocol {
    let shouldThrowError: Bool

    init(shouldThrowError: Bool) {
        self.shouldThrowError = shouldThrowError
    }

    func getArticles(for section: CoreQueryParam, period: Articles.Periods) async throws -> Articles.ResponseModel {
        if shouldThrowError {
            throw NSError(domain: "MockError", code: 1, userInfo: nil)
        }
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return MockDataFactory.articleResponseModel
    }
}
