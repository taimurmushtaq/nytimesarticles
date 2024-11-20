//
//  CoreCoordinator.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import SwiftUI

@Observable
class CoreCoordinator: ObservableObject {
    var path = NavigationPath()
    var rootPage: CorePage?
    
    init(path: NavigationPath = NavigationPath(), rootPage: CorePage? = nil) {
        self.path = path
        self.rootPage = rootPage
    }
}

extension CoreCoordinator {
    func resetPath(to rootPage: CorePage) {
        self.path = NavigationPath()
        self.rootPage = rootPage
    }
    
    func pushView(page: CorePage) {
        path.append(page)
    }
    
    func popView() {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRootView() {
        path.removeLast(path.count)
    }
}

extension CoreCoordinator {
    @ViewBuilder
    func getView(page: CorePage?) -> some View {
        if let page {
            switch page {
            case .articlesList:
                ArticlesFactory.createArticlesScreen()
            case .articleDetails(let article):
                ArticlesFactory.createArticlesDetailScreen(article: article)
            }
        } else {
            EmptyView()
        }
    }
}


