//
//  HamdleProtocol.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc

import Foundation

enum networkEndpoint:APIProtocol{
    case getAllMovieListByPage(pageNo:Int,isAdult:Bool,includeVideo:Bool)
    case getAllTvSeriesListByPage(pageNo:Int,isAdult:Bool)
    case getUserProfile(userId:Int)
    case getMovieGenre
    case getMovieByMovieId(moiveID:Int,isCredits:Bool,isMovie:Bool)
    case getPopularMovieList
    case setFavMovies(movieFav:AddFavMovie)
    
    var baseUrl: URL{
        guard let baseUrl = URL(string:"https://api.themoviedb.org") else{ fatalError()}
        return baseUrl
    }
    
    var endPoint: String{
        switch self {
            case .getAllMovieListByPage:
                return "/3/discover/movie"
            case .getAllTvSeriesListByPage:
                return "/3/discover/tv"
            case .getUserProfile(userId: let userId):
                return "/3/account/\(userId)"
            case .getMovieGenre:
                return "/3/genre/movie/list"
            case .getMovieByMovieId(let moiveID,let isCredits,let isMovie):
                switch isMovie{
                    case true:
                        switch isCredits{
                            case true:
                                return "/3/tv/\(moiveID)/credits"
                            case false:
                                return "/3/tv/\(moiveID)"
                        }
                    case false:
                        switch isCredits{
                            case true:
                                return "/3/movie/\(moiveID)/credits"
                            case false:
                                return "/3/movie/\(moiveID)"
                                
                        }
                }
                
            case .getPopularMovieList:
                return "/3/movie/popular"
            case .setFavMovies:
                return"/3/account/\(21476694)/favorite"
        }
    }
    
    var requestMethod: HttpMethod{
        switch self {
            case .getAllMovieListByPage:
                return .get
            case .getAllTvSeriesListByPage:
                return .get
            case .getUserProfile:
                return.get
            case .getMovieGenre:
                return.get
            case .getMovieByMovieId:
                return .get
            case .getPopularMovieList:
                return .get
            case .setFavMovies:
                return .post
        }
    }
    
    var headers: [String : String]?{
        return [
            "content-type": "application/json",
            "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmU4MjI2MzY4ZTRmYWJiNmQ5OWNmNWEyNTI2YzlkYSIsIm5iZiI6MTcyNTEwMzM5Mi45ODUzNDIsInN1YiI6IjY2ZDJmYzAxMzY1MDk3YTQ1YzAwNTJiZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.neHf13BO1FK9ZUo1FsbeEHQsBEDzSayhhySYHvC7Ygk",
            "accept" : "application/json"
        ]
    }
    
    var parameters: [String : Any]?{
        switch self {
            case .getAllMovieListByPage(pageNo: let pageNo, isAdult: let isAdult, includeVideo: let isVideo):
                return [
                    "include_adult" : isAdult,
                    "include_video" :isVideo,
                    "language"  : "en-US",
                    "page" : pageNo,
                    "sort_by" : "popularity.desc"
                ]
            case .getAllTvSeriesListByPage(pageNo: let pageNo, isAdult: let isAdult):
                return [
                    "include_adult":isAdult,
                    "include_null_first_air_dates":false,
                    "language":"en-US",
                    "page":pageNo,
                    "sort_by":"popularity.desc"
                ]
            case .getUserProfile:
                return nil
            case .getMovieGenre:
                return[
                    "language" : "en"
                ]
        case .getMovieByMovieId:
            return[
                "language":"en-US"
            
            ]
            case .getPopularMovieList:
                return nil
            case .setFavMovies(movieFav: let movieListOfFav):
                return [
                    
                    "media_type" : movieListOfFav.mediaType,
                    "media_id" : movieListOfFav.mediaID,
                    "favorite" : movieListOfFav.favorite
                
                ]
        }
    }
    
    
}
