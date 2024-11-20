//
//  ArticleView.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import Foundation
import SwiftUI

struct ArticleView: View {
    let articleModel: Articles.Model
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            AsyncImage(url: articleModel.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .background(.gray)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(articleModel.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundColor(.black)
                
                HStack {
                    if !articleModel.byline.isEmpty {
                        Text(articleModel.byline)
                            .font(.subheadline)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if !articleModel.publishedDate.isEmpty {
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray)
                            .frame(width: 12, height: 12)
                        Text(articleModel.publishedDate)
                            .font(.caption)
                            .lineLimit(1)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    let responseModel = try? Bundle.main.decode(Articles.ResponseModel.self, from: "Articles.json")
    if let article = responseModel?.results.first {
        return ArticleView(articleModel: article)
    } else {
        return EmptyView()
    }
}
