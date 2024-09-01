//
//  ProfileModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

struct ProfileModel: Codable {
    let avatar: Avatar
    let id: Int
    let iso639_1, iso3166_1, name: String
    let includeAdult: Bool
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
}


struct Avatar: Codable {
    let gravatar: Gravatar
    let tmdb: Tmdb
}


struct Gravatar: Codable {
    let hash: String
}


struct Tmdb: Codable {
    let avatarPath: String?

    enum CodingKeys: String, CodingKey {
        case avatarPath = "avatar_path"
    }
}
