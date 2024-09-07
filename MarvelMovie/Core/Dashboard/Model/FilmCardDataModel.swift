//
//  FilmCardDataModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

struct FilmCardDataModel:Equatable{
    let id:Int
    let posterPath:String
    let title:String
    let voteAvarage:Double
    let pop:Double
    let language:String
    let voteCount:Int
    let isAdult:Bool
    let genreIds:[Int]
    let landscapeImage:String
    
}
