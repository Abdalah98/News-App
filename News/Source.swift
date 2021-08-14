//
//  Source.swift
//  News
//
//  Created by Abdallah on 8/13/21.
//

import Foundation

// MARK: - Source
struct Source: Codable,Hashable {
    let id: String?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
