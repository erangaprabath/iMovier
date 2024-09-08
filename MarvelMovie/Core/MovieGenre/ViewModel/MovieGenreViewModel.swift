//
//  MovieGenreViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

class MovieGenreViewModel:ObservableObject{
    
    private let networkManager = NetworkManager<networkEndpoint>()
    private let getMovieGenre:TmdbDataDownloadServices
    @Published var genreData:MovieGenreModel? = nil
    
    private var dashBoardViewModel:DashboardViewModel
    
    init(dashBoardViewModel:DashboardViewModel) {
        self.getMovieGenre = TmdbDataDownloadServices(networkmanager: networkManager)
        self.dashBoardViewModel = dashBoardViewModel
        Task{ await mapMovieGenre() }
    }
    
   private func mapMovieGenre()async{
        
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
    
    func getFilterdFilms(genreId:Int) {
        dashBoardViewModel.filterMovieByGenreId(genreId: genreId)
    }
    
}
