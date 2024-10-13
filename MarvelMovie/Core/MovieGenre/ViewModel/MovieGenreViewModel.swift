//
//  MovieGenreViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

class MovieGenreViewModel:ObservableObject{
    
    @Published var genreData:MovieGenreModel? = nil
    private var dashBoardViewModel:DashboardViewModel
    
    init(dashBoardViewModel:DashboardViewModel) {
        self.dashBoardViewModel = dashBoardViewModel
        Task{
            await mapMovieGenre()
        }
    }
    
    func mapMovieGenre()async{
        
        Task{ @MainActor [weak self] in
            
            let movieGenreData = await self?.dashBoardViewModel.allFilmService.downloadMovieGenre()
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
    
    @MainActor func getFilterdFilms(genreId:Int) {
        dashBoardViewModel.filterMovieByGenreId(genreId: genreId)
    }
    
}
