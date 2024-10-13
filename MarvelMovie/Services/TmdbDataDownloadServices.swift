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
    
    private func performRequest<T:Decodable>(for endPoint:networkEndpoint) async -> Result<T,APIError>{
        do {
            let fetchData:T  = try await networkManager.downloadData(endpoints: endPoint)
            return.success(fetchData)
        }catch{
            return .failure(APIError.decodingError(error: error))
        }
    }
    
    func downloadAllFilmData(pageNo:Int) async -> Result<MovieModel,APIError>{
        let allMovies = networkEndpoint.getAllMovieListByPage(pageNo: pageNo, isAdult: true, includeVideo: true)
        return await performRequest(for: allMovies)
    }
    func donwloadAllTvSeries(pageNo:Int) async -> Result<AllTvSeriesModel,APIError>{
        let allTvSeries = networkEndpoint.getAllTvSeriesListByPage(pageNo: pageNo, isAdult: true)
        return await performRequest(for: allTvSeries)
    }
    func dwonloadUsreDetails(userId:Int) async -> Result<ProfileModel,APIError>{
        let getUserEndPoint = networkEndpoint.getUserProfile(userId: userId)
        return await performRequest(for: getUserEndPoint)
    }
    func downloadMovieGenre() async -> Result<MovieGenreModel, APIError>{
        let movieGenreEndpoint = networkEndpoint.getMovieGenre
        return await performRequest(for: movieGenreEndpoint)
    }
    func downloadSingleMovieData(movieID:Int,isMovie:Bool) async -> Result<SingleMovieAndTvSeiresModel,APIError>{
        let singleMoiveEndPoint = networkEndpoint.getMovieByMovieId(movieID: movieID, isCredits: false, isMovie: isMovie)
        return await performRequest(for: singleMoiveEndPoint)
    }
    func downloadSingleMovieCastAndCrew(movieID:Int,isMoive:Bool) async -> Result<CastAndCrewModel,APIError>{
        let singleMoiveCrewEndPoint = networkEndpoint.getMovieByMovieId(movieID: movieID, isCredits: true, isMovie: isMoive)
        return await performRequest(for: singleMoiveCrewEndPoint)
    }
    func downloadPopularMovieSet() async -> Result<MovieModel,APIError>{
        let popMovieEndPoint = networkEndpoint.getPopularMovieList
        return await performRequest(for: popMovieEndPoint)
    }
    func uploadFavMovie(favMovieData:AddFavMovie) async -> Result<SuccessModel,APIError>{
        let favMovieEndPoint = networkEndpoint.setFavMovies(movieFav: favMovieData)
        return await performRequest(for: favMovieEndPoint)
    }
    func getFavMovieList() async -> Result<FavMovieModel,APIError>{
        let favMovieListEndPoint = networkEndpoint.getFavMovies
        return await performRequest(for: favMovieListEndPoint)
    }
  
}

struct error:Error{
    
}
