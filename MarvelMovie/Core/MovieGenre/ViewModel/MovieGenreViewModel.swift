//
//  MovieGenreViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

class MovieGenreViewModel:ObservableObject{
    
    private let networkManager = NetworkManager<networkEndpoint>()
    private let getMovieGenre:MovieGenreService
    @Published var genreData:MovieGenreModel? = nil
    
    init() {
        self.getMovieGenre = MovieGenreService(networkMager: networkManager)
        mapMovieGenre()
    }
    
    func mapMovieGenre(){
        
        Task{ @MainActor [weak self] in
            
            let movieGenreData = await self?.getMovieGenre.downloadMovieGenre()
            switch movieGenreData {
                case .success(let movieGenreData):
                    self?.genreData = movieGenreData
                case .failure(let failure):
                    print("Data Fecth error \(failure)")
                case .none:
                    print(APIError.unknownError)
            }
            
        }
    }
    
}
