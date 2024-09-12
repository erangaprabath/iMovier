//
//  AllFilmService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

actor TmdbDataDownloadServices{
    private var networkManager:NetworkManager<networkEndpoint>
    
    init(networkmanager: NetworkManager<networkEndpoint>) {
        self.networkManager = networkmanager
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
            print(error)
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
    func downloadSingleMovieData(movieID:Int,isMovie:Bool) async -> Result<SingleMovieAndTvSeiresModel,APIError>{
        let apiEndPoint = networkEndpoint.getMovieByMovieId(moiveID: movieID, isCredits: false, isMovie: isMovie)
        do{
            let fetchData:SingleMovieAndTvSeiresModel = try await networkManager.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
    }
    func downloadSingleMovieCastAndCrew(movieID:Int,isMoive:Bool) async -> Result<CastAndCrewModel,APIError>{
        let apiEndPoint = networkEndpoint.getMovieByMovieId(moiveID: movieID, isCredits: true, isMovie: isMoive)
        do{
            let fetchData:CastAndCrewModel = try await networkManager.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
    }
    func downloadPopularMovieSet() async -> Result<MovieModel,APIError>{
        let apiEndPoint = networkEndpoint.getPopularMovieList
        do {
            let fetchData:MovieModel  = try await networkManager.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
        
    }
}
