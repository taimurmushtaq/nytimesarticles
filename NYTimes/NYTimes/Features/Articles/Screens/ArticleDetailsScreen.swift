//
//  ArticleDetailsScreen.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import SwiftUI

struct ArticleDetailsScreen: View {
    @StateObject var viewModel: ArticleDetailsScreenViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Media View
                if let photoGallery = viewModel.photoGallery {
                    VStack {
                        AsyncImage(url: URL(string: photoGallery.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        
                        if !photoGallery.caption.isEmpty {
                            Text(photoGallery.caption)
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, 4)
                        }
                    }
                }
                
                // Title
                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                // Byline
                Text(viewModel.byline)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Published and Updated Dates
                HStack {
                    Text(viewModel.publishedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(viewModel.updated)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Abstract
                Text(viewModel.abstract)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                
                // Source and Section
                HStack {
                    Text(viewModel.source)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(viewModel.section)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                // Link to Article
                Link("ReadFullArticle", destination: viewModel.fullArticleURL)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.top, 10)
            }
            .padding()
        }
        .navigationTitle("ArticleDetails")
    }
}

#Preview {
    let responseModel = try? Bundle.main.decode(Articles.ResponseModel.self, from: "Articles.json")
    if let article = responseModel?.results.first {
        return ArticleDetailsScreen(viewModel: ArticleDetailsScreenViewModel(article: article))
    } else {
        return EmptyView()
    }
}
