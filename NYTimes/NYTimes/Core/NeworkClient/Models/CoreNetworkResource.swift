//
//  CoreNetworkResource.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import Foundation

struct CoreNetworkResource<T: Codable> {
    let method: CoreHTTPMethod
    let url: URL
    var headers: [String: String]? = nil
    let modelType: T.Type
}
