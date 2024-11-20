//
//  ArticleDetailsScreenViewModelTests.swift
//  NYTimesTests
//
//  Created by Taimur on 20/11/2024.
//

import XCTest
@testable import NYTimes

final class ArticleDetailsScreenViewModelTests: XCTestCase {
    let viewModel = ArticleDetailsScreenViewModel(article: MockDataFactory.articleModel)

    func testPhotoGallery() {
        let photoGallery = viewModel.photoGallery

        XCTAssertNotNil(photoGallery)
        XCTAssertEqual(photoGallery?.url, "https://static01.nyt.com/images/2024/11/14/multimedia/14goldberg-lpwc/14goldberg-lpwc-mediumThreeByTwo440.jpg")
        XCTAssertEqual(photoGallery?.caption, "")
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Matt Gaetz Is the Perfect Man for the Job")
    }

    func testByline() {
        XCTAssertEqual(viewModel.byline, "By Michelle Goldberg")
    }

    func testPublishedDate() {
        XCTAssertEqual(viewModel.publishedDate, "Published: 2024-11-14")
    }

    func testUpdated() {
        XCTAssertEqual(viewModel.updated, "Updated: 2024-11-18 14:17:45")
    }

    func testAbstract() {
        XCTAssertEqual(viewModel.abstract, "Trump’s choice to lead the Justice Department is a flagrant provocation that is, like a pulpy B movie, so bad, it’s good.")
    }

    func testSource() {
        XCTAssertEqual(viewModel.source, "Source: New York Times")
    }

    func testSection() {
        XCTAssertEqual(viewModel.section, "Section: Opinion")
    }

    func testFullArticleURL() {
        XCTAssertEqual(viewModel.fullArticleURL, URL(string: "https://www.nytimes.com/2024/11/14/opinion/i-cant-wait-for-matt-gaetzs-confirmation-hearings.html"))
    }
}
