//
//  SingleMovieViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//

import Foundation

class SingleMovieViewModel:ObservableObject{
    
    private let networkManager = NetworkManager<networkEndpoint>()
    private let getSingleMovieService:GetSingleMovieService
    @Published var movieMainDeitails:SingleMovieModel? = nil
    
    init() {
        self.getSingleMovieService = GetSingleMovieService(networkManger: networkManager)
    }
    
    func mapSingleMovieDetals(movieId:Int)async{
        Task {@MainActor [weak self] in
            let singleMoiveData = await self?.getSingleMovieService.downloadSingleMovieData(movieID: movieId)
            switch singleMoiveData {
                case .success(let singleMovie):
                    self?.movieMainDeitails = singleMovie
                case .failure(let failure):
                    print(failure)
                case .none:
                    print("")
            }
            
        }
    }
}
