//
//  AllFilmService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

actor TmdbDataDownloadServices{
    private var networkManager:NetworkManager<networkEndpoint>
    
    init(networkmanger: NetworkManager<networkEndpoint>) {
        self.networkManager = networkmanger
    }
    
    func downloadAllFilmData(pageNo:Int) async -> Result<MovieModel,Error>{
     
        let allMovies = networkEndpoint.getAllMovieListByPage(pageNo: pageNo, isAdult: true, includeVideo: true)
        do {
            let fetchData:MovieModel = try await networkManager.downloadData(endpoints: allMovies)
            return .success(fetchData)
            
        }catch{
            return.failure(error)
        }
        
    }
    func donwloadAllTvSeries(pageNo:Int) async -> Result<AllTvSeriesModel,Error>{
        let allTvSeries = networkEndpoint.getAllTvSeriesListByPage(pageNo: pageNo, isAdult: true)
        do{
            let fetchData:AllTvSeriesModel = try await networkManager.downloadData(endpoints: allTvSeries)
            return.success(fetchData)
        }catch{
            return .failure(error)
        }
    }
    func dwonloadUsreDetails(userId:Int) async -> Result<ProfileModel,APIError>{
        let getUserEndPoint = networkEndpoint.getUserProfile(userId: userId)
        do {
            let fetchData:ProfileModel = try await networkManager.downloadData(endpoints: getUserEndPoint)
            return .success(fetchData)
        }catch{
            return .failure(APIError.decodingError(error: error))
        }
    }
    func downloadMovieGenre() async -> Result<MovieGenreModel, APIError>{
        let movieGenreEndpoint = networkEndpoint.getMovieGenre
        do{
            let fetchData:MovieGenreModel = try await networkManager.downloadData(endpoints: movieGenreEndpoint)
            return .success(fetchData)
        }catch{
            return .failure(APIError.decodingError(error: error))
        }
    }
    func downloadSingleMovieData(movieID:Int) async -> Result<SingleMovieModel,APIError>{
        let apiEndPoint = networkEndpoint.getMovieByMovieId(moiveID: movieID, isCredits: false)
        do{
            let fetchData:SingleMovieModel = try await networkManager.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
    }
    func downloadSingleMovieCastAndCrew(movieID:Int) async -> Result<CastAndCrewModel,APIError>{
        let apiEndPoint = networkEndpoint.getMovieByMovieId(moiveID: movieID, isCredits: true)
        do{
            let fetchData:CastAndCrewModel = try await networkManager.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
    }
}
