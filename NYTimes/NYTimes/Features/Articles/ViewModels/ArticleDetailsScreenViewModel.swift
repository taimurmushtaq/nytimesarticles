//
//  ArticleDetailsScreenViewModel.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import Foundation
import SwiftUI

@Observable
class ArticleDetailsScreenViewModel: ObservableObject {
    let article: Articles.Model
    
    init(article: Articles.Model) {
        self.article = article
    }
}

extension ArticleDetailsScreenViewModel {
    var photoGallery: Articles.Model.PhotoGallery? {
        guard let media = article.media.first,
              let photo = media.mediaMetadata.last else { return nil }
        
        return Articles.Model.PhotoGallery(url: photo.url, caption: media.caption)
    }
    
    var title: String { article.title }
    var byline: String { article.byline }
    var publishedDate: String { "Published: \(article.publishedDate)" }
    var updated: String { "Updated: \(article.updated)" }
    var abstract: String { article.abstract }
    var source: String { "Source: \(article.source)" }
    var section: String { "Section: \(article.section)" }
    
    var fullArticleURL: URL { URL(string: article.url)! }
    
}

