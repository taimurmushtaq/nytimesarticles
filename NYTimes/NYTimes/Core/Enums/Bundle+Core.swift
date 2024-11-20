//
//  Bundle+Core.swift
//  NYTimes
//
//  Created by MAC918580 on 20/11/2024.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw CoreNetworkError.parsingError(description: "Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw CoreNetworkError.parsingError(description: "Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            throw CoreNetworkError.parsingError(description: "Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
