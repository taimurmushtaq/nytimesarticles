//
//  ArticlesListScreenViewModel.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import Foundation
import SwiftUI

@Observable
class ArticlesListScreenViewModel: ObservableObject {
    //MARK: - Public Properties
    var mostViewArticlesList = [Articles.Model]()
    var filteredArticlesList: [Articles.Model] {
        if searchText.isEmpty {
            return mostViewArticlesList
        } else {
            return mostViewArticlesList.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    var searchText = ""
    var isLoading: Bool = false
    var alertManager = CoreAlertManager()
    
    //MARK: - Private Properties
    private let mostViewedArticlesNS: MostViewedArticlesNetworkServiceProtocol
    
    //MARK: - Lifecycle
    init(mostViewedArticlesNS: MostViewedArticlesNetworkServiceProtocol) {
        self.mostViewedArticlesNS = mostViewedArticlesNS
    }
    
    //MARK: - API Call
    func getMostViewArticles() async {
        isLoading = true
        do  {
            mostViewArticlesList = try await mostViewedArticlesNS.getArticles(for: .allSections, period: .seven).results
            isLoading = false
        } catch let error {
            isLoading = false

            let errorMessage = (error as? CoreNetworkError)?.description ?? error.localizedDescription
            alertManager.showAlert(model: CoreAlertModel(title: "Alert!", message: errorMessage, primaryButton: .cancel()))
        }
    }
}

