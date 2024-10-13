//
//  SingleMovieViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//

import Foundation

final class SingleMovieViewModel:ObservableObject{
    
    let networkManager:NetworkManager<networkEndpoint>
    private let getSingleMovieService:TmdbDataDownloadServices
    @Published private(set) var movieMainDeitails:SingleMovieAndTvSeiresModel? = nil
    @Published private(set) var movieCastAndCrew:CastAndCrewModel? = nil
    private var tasks:[Task<Void ,Never>] = []
    
    init(networkManager:NetworkManager<networkEndpoint>,tmdbServiceLayer:TmdbDataDownloadServices) {
        self.networkManager = networkManager
        self.getSingleMovieService = tmdbServiceLayer
       
    }
    func cancelTask(){
        tasks.forEach({$0.cancel()})
        tasks = []
    }
    
    func mapSingleMovieDetals(movieId:Int,isMovie:Bool) async {
       let task = Task {@MainActor  in
           let singleMoiveData = await getSingleMovieService.downloadSingleMovieData(movieID: movieId, isMovie: isMovie)
            mapMovieData(singleMoiveData: singleMoiveData)
           let singleMoiveCastAndCrewData = await getSingleMovieService.downloadSingleMovieCastAndCrew(movieID: movieId, isMoive: isMovie)
            mapMovieCrewData(singleMoiveCastAndCrewData: singleMoiveCastAndCrewData)
            
        }
        tasks.append(task)
        
    }
    private func mapMovieData(singleMoiveData:Result<SingleMovieAndTvSeiresModel,APIError>?){
        switch singleMoiveData {
            case .success(let singleMovie):
                self.movieMainDeitails = singleMovie
            case .failure(let failure):
                print(failure)
            case .none:
                print("Unknown Error")
        }
    }
    private func mapMovieCrewData(singleMoiveCastAndCrewData:Result<CastAndCrewModel,APIError>?){
        switch singleMoiveCastAndCrewData {
            case .success(let singleMovie):
                self.movieCastAndCrew = singleMovie
            case .failure(let failure):
                print(failure)
            case .none:
                print("Unknown Error")
        }
    }
    func setFavMoive(favMovieData:AddFavMovie) async{
        let task = Task{ @MainActor in
            let successMessage = await getSingleMovieService.uploadFavMovie(favMovieData:favMovieData)
            switch successMessage {
                case .success(let success):
                    print(success)
                case .failure(let failure):
                    print(failure)
            }
            
        }
        tasks.append(task)
    }
}
