//
//  CoreNetworkError.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import Foundation

enum CoreNetworkError: Error {
    case badRequest
    case networkError(code: Int)
    case parsingError(description: String)
    case invalidResponse
    case unknownError
    
    var description: String {
        switch self {
        case .badRequest:
            return "The request was invalid. Please check and try again."
        case .networkError(let code):
            return "Network error occurred. Code: \(code)"
        case .parsingError(let description):
            return "An error occurred while parsing the data: \(description)"
        case .invalidResponse:
            return "The server response was invalid. Please try again later."
        case .unknownError:
            return "An unknown error occurred. Please contact support."
        }
    }
}
