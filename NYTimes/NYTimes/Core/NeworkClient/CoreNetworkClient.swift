//
//  CoreNetworkClient.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import Foundation

protocol CoreNetworkClientProtocol {
    func load<T: Codable>(_ resource: CoreNetworkResource<T>) async throws -> T
}

struct CoreNetworkClient: CoreNetworkClientProtocol {
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [CoreNetworkHeaderConstants.contentType: CoreNetworkHeaderConstants.applicationJson]
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Codable>(_ resource: CoreNetworkResource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                throw CoreNetworkError.badRequest
            }
            request.url = url
            
        case .post(let data), .put(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
            
        case .delete:
            request.httpMethod = resource.method.name
        }
        
        // Set custom headers
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw CoreNetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
        case 200...299:
            break // Success
        default:
            throw CoreNetworkError.networkError(code: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw CoreNetworkError.parsingError(description: error.localizedDescription)
        }
    }
}
