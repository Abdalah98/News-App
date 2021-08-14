//
//  TopHeadlinesSources.swift
//  News
//
//  Created by Abdallah on 8/8/21.
//

import Foundation
// MARK: - TopHeadlinesSources
struct TopHeadlinesSources: Codable {
    let status: String?
    let sources: [SourceData]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case sources = "sources"
    }
}

