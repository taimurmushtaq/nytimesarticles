//
//  ArticlesListScreenViewModelTests.swift
//  NYTimesTests
//
//  Created by Taimur on 20/11/2024.
//

import XCTest
@testable import NYTimes

final class ArticlesListScreenViewModelTests: XCTestCase {
    func testFilteredArticlesList_withEmptySearchText_returnsAllArticles() {
        let mockService = MockMostViewedArticlesNetworkService(shouldThrowError: false)

        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: mockService)
        viewModel.searchText = ""
        viewModel.mostViewArticlesList = [MockDataFactory.articleModel, MockDataFactory.articleModel]

        XCTAssertEqual(viewModel.filteredArticlesList.count, 2, "Filtered list should contain all articles when searchText is empty.")
    }

    func testFilteredArticlesList_withSearchText_filtersArticles() {
        let mockService = MockMostViewedArticlesNetworkService(shouldThrowError: false)

        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: mockService)
        viewModel.searchText = "Matt Gaetz"
        viewModel.mostViewArticlesList = MockDataFactory.articleResponseModel.results

        XCTAssertEqual(viewModel.filteredArticlesList.count, 1, "Filtered list should only contain articles matching the search text.")
        XCTAssertEqual(viewModel.filteredArticlesList.first?.title, "Matt Gaetz Is the Perfect Man for the Job")
    }

    func testGetMostViewArticles_success() async {
        let mockService = MockMostViewedArticlesNetworkService(shouldThrowError: false)

        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: mockService)
        await viewModel.getMostViewArticles()

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after successful API call.")
        XCTAssertFalse(viewModel.alertManager.isPresented, "isPresented should be false after API call failure.")
        XCTAssertEqual(viewModel.filteredArticlesList.count, 20, "ViewModel should correctly populate the articles list on successful API call.")
    }

    func testGetMostViewArticles_failure() async {
        let mockService = MockMostViewedArticlesNetworkService(shouldThrowError: true)

        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: mockService)
        await viewModel.getMostViewArticles()

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after API call failure.")
        XCTAssertTrue(viewModel.alertManager.isPresented, "isPresented should be true after API call failure.")
        XCTAssertEqual(viewModel.filteredArticlesList.count, 0, "ViewModel should have an empty articles list after API call failure.")

    }

    func testIsLoading_updatesCorrectlyDuringAPICall() async {
        let mockService = MockMostViewedArticlesNetworkService(shouldThrowError: false)
        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: mockService)

        let task = Task {
            await viewModel.getMostViewArticles()
        }

        try! await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertTrue(viewModel.isLoading, "isLoading should be true during the API call.")

        await task.value
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after the API call completes.")
    }
}
