//
//  ArticlesResponseModel.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import Foundation

enum Articles { }

extension Articles {
    enum Urls {
        case mostViewed(String, String)
        
        var urlString: String {
            switch self {
            case let .mostViewed(section, period):
                return "\(CoreConstants.baseURL)/svc/mostpopular/v2/mostviewed/\(section)/\(period).json"
            }
        }
        
        var url: URL? { URL(string: urlString) }
    }
}

extension Articles {
    enum Periods: String {
        case one = "1"
        case seven = "7"
        case thirty = "30"
    }
}

extension Articles {
    struct ResponseModel: Codable {
        let status: String
        let copyright: String
        let numResults: Int
        let results: [Model]
        
        // Map the JSON keys to Swift properties
        enum CodingKeys: String, CodingKey {
            case status
            case copyright
            case numResults = "num_results"
            case results
        }
    }
    
    struct Model: Codable, Identifiable, Equatable, Hashable {
        let id: Int
        let uri: String
        let url: String
        let assetId: Int
        let source: String
        let publishedDate: String
        let updated: String
        let section: String
        let subsection: String
        let nytdsection: String
        let adxKeywords: String
        let column: String?
        let byline: String
        let type: String
        let title: String
        let abstract: String
        let desFacet: [String]
        let orgFacet: [String]
        let perFacet: [String]
        let geoFacet: [String]
        let media: [MediaModel]
        
        // Map the JSON keys to Swift properties
        enum CodingKeys: String, CodingKey {
            case id
            case uri
            case url
            case assetId = "asset_id"
            case source
            case publishedDate = "published_date"
            case updated
            case section
            case subsection
            case nytdsection
            case adxKeywords = "adx_keywords"
            case column
            case byline
            case type
            case title
            case abstract
            case desFacet = "des_facet"
            case orgFacet = "org_facet"
            case perFacet = "per_facet"
            case geoFacet = "geo_facet"
            case media
        }
        
        static func == (lhs: Model, rhs: Model) -> Bool { lhs.id == rhs.id }
    }
    
    struct MediaModel: Codable, Hashable {
        let type: String
        let subtype: String
        let caption: String
        let copyright: String
        let approvedForSyndication: Int
        let mediaMetadata: [MediaMetaDataModel]
        
        // Map the JSON keys to Swift properties
        enum CodingKeys: String, CodingKey {
            case type
            case subtype
            case caption
            case copyright
            case approvedForSyndication = "approved_for_syndication"
            case mediaMetadata = "media-metadata"
        }
    }
    
    struct MediaMetaDataModel: Codable, Hashable {
        let url: String
        let format: String
        let height: Int
        let width: Int
    }
    
}

extension Articles.Model {
    var imageURL: URL? { URL(string: media.first?.mediaMetadata.first?.url ?? "") }
}

extension Articles.Model {
    struct PhotoGallery: Codable, Hashable {
        let url, caption: String
    }
}
