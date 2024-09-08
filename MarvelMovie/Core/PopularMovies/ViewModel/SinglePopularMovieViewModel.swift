//
//  SinglePopularMovieViewModel.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-06.
//

import Foundation

class SinglePopularMovieViewModel:ObservableObject{
    private var moviewViewModel:DashboardViewModel
    
    init(moviewViewModel: DashboardViewModel) {
        self.moviewViewModel = moviewViewModel
    }
    func mapPopMovie() -> [FilmCardDataModel]{
        let allMoives = self.moviewViewModel.movieDataSet
        let popMovie = allMoives.filter({$0.voteAvarage > 6.5})
        return popMovie
        
    }
}
