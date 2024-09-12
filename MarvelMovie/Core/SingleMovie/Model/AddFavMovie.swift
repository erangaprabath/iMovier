//
//  File.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-12.
//

import Foundation

struct AddFavMovie: Codable {
    let mediaType: String
    let mediaID: Int
    let favorite: Bool

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaID = "media_id"
        case favorite
    }
}
