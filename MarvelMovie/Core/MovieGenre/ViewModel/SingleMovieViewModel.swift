//
//  SingleMovieViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//

import Foundation

final class SingleMovieViewModel:ObservableObject{
    
    private let networkManager = NetworkManager<networkEndpoint>()
    private let getSingleMovieService:TmdbDataDownloadServices
    @Published private(set) var movieMainDeitails:SingleMovieModel? = nil
    @Published private(set) var movieCastAndCrew:CastAndCrewModel? = nil
    private var tasks:[Task<Void ,Never>] = []
    
    init() {
        self.getSingleMovieService = TmdbDataDownloadServices(networkmanager: networkManager)
    }
    func cancelTask(){
        tasks.forEach({$0.cancel()})
        tasks = []
    }
    
    func mapSingleMovieDetals(movieId:Int) async {
       let task = Task {@MainActor  in
            let singleMoiveData = await getSingleMovieService.downloadSingleMovieData(movieID: movieId)
            mapMovieData(singleMoiveData: singleMoiveData)
            let singleMoiveCastAndCrewData = await getSingleMovieService.downloadSingleMovieCastAndCrew(movieID: movieId)
            mapMovieCrewData(singleMoiveCastAndCrewData: singleMoiveCastAndCrewData)
            
        }
        tasks.append(task)
        
    }
    private func mapMovieData(singleMoiveData:Result<SingleMovieModel,APIError>?){
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
}
