//
//  SourcesData.swift
//  News
//
//  Created by Abdallah on 8/13/21.
//

import Foundation

// MARK: - Source
struct SourceData: Codable {
    let id: String?
    let name: String?
    let sourceDescription: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case sourceDescription = "description"
        case url = "url"
        case category = "category"
        case language = "language"
        case country = "country"
    }
}
