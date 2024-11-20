//
//  ArticlesListScreen.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import SwiftUI

struct ArticlesListScreen: View {
    @EnvironmentObject var coordinator: CoreCoordinator
    @StateObject var viewModel: ArticlesListScreenViewModel
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.filteredArticlesList.isEmpty && !viewModel.isLoading {
                    Text("NoArticlesFound")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(viewModel.filteredArticlesList) { article in
                        ArticleView(articleModel: article)
                            .padding()
                            .listRowInsets(EdgeInsets())
                            .onTapGesture {
                                coordinator.pushView(page: .articleDetails(article) )
                            }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "SearchArticles")
            .listStyle(PlainListStyle())
            .navigationTitle("ArticleTitle")
            .toolbarTitleDisplayMode(.inline)
            .refreshable {
                await viewModel.getMostViewArticles()
            }
            .task {
                await viewModel.getMostViewArticles()
            }
            .showLoader(isLoading: viewModel.isLoading)
            .showAlert(with: viewModel.alertManager)
        }
    }
}

#Preview {
    ArticlesListScreen(viewModel: ArticlesListScreenViewModel(mostViewedArticlesNS: MostViewedArticlesNetworkService()))
}
