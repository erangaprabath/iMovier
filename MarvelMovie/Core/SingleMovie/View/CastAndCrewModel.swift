//
//  CastAndCrewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-07.
//

import Foundation
struct CastAndCrewModel: Codable {
    let id: Int
    let cast, crew: [Cast]
}
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case crew = "Crew"
    case directing = "Directing"
    case production = "Production"
    case sound = "Sound"
    case writing = "Writing"
}
