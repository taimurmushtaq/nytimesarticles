//
//  CoreConstants.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import Foundation

struct CoreConstants {
    static let baseURL = "http://api.nytimes.com"
    static let apiKey = "LJNMGKqw4xFv1kGeOXiiGh4PXT7bgTXj"
}

struct CoreNetworkHeaderConstants {
    static let contentType = "Content-Type"
    static let applicationJson = "application/json"
}

enum CoreQueryParam: String {
    case apiKey = "api-key"
    case allSections = "all-sections"
}
