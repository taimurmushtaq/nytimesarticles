//
//  CoreCoordinatorTests.swift
//  NYTimesTests
//
//  Created by Taimur on 20/11/2024.
//

import XCTest
import SwiftUI

@testable import NYTimes

class CoreCoordinatorTests: XCTestCase {
    var coordinator: CoreCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = CoreCoordinator()
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }

    func testPushView() {
        let page = CorePage.articlesList
        coordinator.pushView(page: page)

        XCTAssertEqual(coordinator.path.count, 1)
    }

    func testPopView() {
        let page = CorePage.articlesList
        coordinator.pushView(page: page)

        coordinator.popView()

        XCTAssertTrue(coordinator.path.isEmpty)
    }

    func testResetPath() {
        let page1 = CorePage.articlesList
        let page2 = CorePage.articleDetails(MockDataFactory.articleModel)

        coordinator.pushView(page: page1)
        coordinator.pushView(page: page2)

        coordinator.resetPath(to: page1)

        XCTAssertEqual(coordinator.path.count, 0)
        XCTAssertEqual(coordinator.rootPage, page1)
    }

    func testPopToRootView() {
        let page1 = CorePage.articlesList
        let page2 = CorePage.articleDetails(MockDataFactory.articleModel)

        coordinator.pushView(page: page1)
        coordinator.pushView(page: page2)

        coordinator.popToRootView()

        XCTAssertEqual(coordinator.path.count, 0)
    }

    func testGetView() {
        let page = CorePage.articlesList
        let view = coordinator.getView(page: page)

        XCTAssertNotNil(view)
    }
}
