//
//  TopHeadlinesCountry.swift
//  News
//
//  Created by Abdallah on 8/8/21.
//

import Foundation
// MARK: - TopHeadlinesCountry
struct TopHeadlinesCountry: Codable ,Hashable{
    let status: String?
    let totalResults: Int?
    let articles: [Article]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

