//
//  HamdleProtocol.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc

import Foundation

enum networkEndpoint: APIProtocol {
    case getAllMovieListByPage(pageNo: Int, isAdult: Bool, includeVideo: Bool)
    case getAllTvSeriesListByPage(pageNo: Int, isAdult: Bool)
    case getUserProfile(userId: Int)
    case getMovieGenre
    case getMovieByMovieId(movieID: Int, isCredits: Bool, isMovie: Bool)
    case getPopularMovieList
    case setFavMovies(movieFav: AddFavMovie)
    case getFavMovies
    
    var baseUrl: URL {
        guard let baseUrl = URL(string: "https://api.themoviedb.org") else {
            fatalError("Invalid base URL")
        }
        return baseUrl
    }
    
    var endPoint: String {
        switch self {
            case .getAllMovieListByPage:
                return "/3/discover/movie"
            case .getAllTvSeriesListByPage:
                return "/3/discover/tv"
            case .getUserProfile(let userId):
                return "/3/account/\(userId)"
            case .getMovieGenre:
                return "/3/genre/movie/list"
            case .getMovieByMovieId(let movieID, let isCredits, let isMovie):
                return isMovie
                    ? (isCredits ? "/3/tv/\(movieID)/credits" : "/3/tv/\(movieID)")
                    : (isCredits ? "/3/movie/\(movieID)/credits" : "/3/movie/\(movieID)")
            case .getPopularMovieList:
                return "/3/movie/popular"
            case .setFavMovies:
                return "/3/account/\(21476694)/favorite"
            case .getFavMovies:
                return "/3/account/\(21476694)/favorite/movies"
            
        }
    }
    
    var requestMethod: HttpMethod {
        switch self {
            case .setFavMovies:
                return .post
            default:
                return .get
        }
    }
    
    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MmU4MjI2MzY4ZTRmYWJiNmQ5OWNmNWEyNTI2YzlkYSIsIm5iZiI6MTcyNTEwMzM5Mi45ODUzNDIsInN1YiI6IjY2ZDJmYzAxMzY1MDk3YTQ1YzAwNTJiZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.neHf13BO1FK9ZUo1FsbeEHQsBEDzSayhhySYHvC7Ygk",
            "Accept": "application/json"
        ]
    }
    
    var parameters: [String: Any]? {
        switch self {
            case .getAllMovieListByPage(let pageNo, let isAdult, let includeVideo):
                return [
                    "include_adult": isAdult,
                    "include_video": includeVideo,
                    "language": "en-US",
                    "page": pageNo,
                    "sort_by": "popularity.desc"
                ]
            case .getAllTvSeriesListByPage(let pageNo, let isAdult):
                return [
                    "include_adult": isAdult,
                    "include_null_first_air_dates": false,
                    "language": "en-US",
                    "page": pageNo,
                    "sort_by": "popularity.desc"
                ]
            case .getUserProfile:
                return nil
            case .getMovieGenre:
                return ["language": "en"]
            case .getMovieByMovieId:
                return ["language": "en-US"]
            case .getPopularMovieList:
                return nil
            case .setFavMovies(let movieFav):
                return [
                    "media_type": movieFav.mediaType,
                    "media_id": movieFav.mediaID,
                    "favorite": movieFav.favorite
                ]
            case .getFavMovies:
                return nil
        }
    }
}
