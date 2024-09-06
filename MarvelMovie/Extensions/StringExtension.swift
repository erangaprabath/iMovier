//
//  StringExtension.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//

import Foundation

extension String {
    static func averageFormatter(from value: Double) -> String {
        return String(format: "%.2f", value)
    }
    
    static func averageFormatter(from value: Int) -> String {
        return String(format: "%.2d", value)
    }
    
    static func posterBaseUrl(quality:String) -> String{
        return "https://image.tmdb.org/t/p/w\(quality)"
    }
}
