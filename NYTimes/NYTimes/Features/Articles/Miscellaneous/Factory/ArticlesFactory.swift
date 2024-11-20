//
//  File.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import Foundation
import SwiftUI

struct ArticlesFactory {
    static func createArticlesScreen() -> some View {
        let networkService = MostViewedArticlesNetworkService()
        let viewModel = ArticlesListScreenViewModel(mostViewedArticlesNS: networkService)
        return ArticlesListScreen(viewModel: viewModel)
    }
    
    static func createArticlesDetailScreen(article: Articles.Model) -> some View {
        let viewModel = ArticleDetailsScreenViewModel(article: article)
        return ArticleDetailsScreen(viewModel: viewModel)
    }
}
