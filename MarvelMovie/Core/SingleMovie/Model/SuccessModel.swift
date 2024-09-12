//
//  SuccessModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-12.
//

import Foundation

struct SuccessModel: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
