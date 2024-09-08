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
    @Published var movieMainDeitails:SingleMovieModel? = nil
    @Published var movieCastAndCrew:CastAndCrewModel? = nil
    
    init() {
        self.getSingleMovieService = TmdbDataDownloadServices(networkmanger: networkManager)
    }
    
    func mapSingleMovieDetals(movieId:Int)async{
        Task {@MainActor [weak self] in
            let singleMoiveData = await self?.getSingleMovieService.downloadSingleMovieData(movieID: movieId)
            self?.mapMovieData(singleMoiveData: singleMoiveData)
            let singleMoiveCastAndCrewData = await self?.getSingleMovieService.downloadSingleMovieCastAndCrew(movieID: movieId)
            self?.mapMovieCrewData(singleMoiveCastAndCrewData: singleMoiveCastAndCrewData)
            
        }
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
