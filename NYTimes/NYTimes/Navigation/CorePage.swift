//
//  CorePage.swift
//  NYTimes
//
//  Created by Taimur on 18/11/2024.
//

import SwiftUI

enum CorePage: Hashable, Identifiable {
    case articlesList
    case articleDetails(Articles.Model)
    
    var id: Self { self }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .articlesList:
            hasher.combine(0)
        case .articleDetails(let article):
            hasher.combine(article.id)
        }
    }
    
    static func ==(lhs: CorePage, rhs: CorePage) -> Bool { lhs.hashValue == rhs.hashValue }
}
