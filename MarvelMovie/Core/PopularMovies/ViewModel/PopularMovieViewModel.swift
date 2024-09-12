//
//  SinglePopularMovieViewModel.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-06.
//

import Foundation

class PopularMovieViewModel:ObservableObject{
    private var moviewViewModel:DashboardViewModel
    @Published private(set) var popularMovies:[FilmCardDataModel] = []
    private var tasks:[Task<Void ,Never>] = []
    
    init(moviewViewModel: DashboardViewModel) {
        self.moviewViewModel = moviewViewModel
        setData()
    }
    
    private func setData(){
        let task = Task {
            await getPopluarMovieList()
        }
        tasks.append(task)
    }
    
    @MainActor
    private func getPopluarMovieList() async{
            let popMovies = await moviewViewModel.allFilmService.downloadPopularMovieSet()
            switch popMovies {
                case .success(let recivedPopMovie):
                    popularMovies = recivedPopMovie.results.map({mapPopMoivesTouseDataModel(recivedData: $0)})
                    print("data recive")
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
       
    }
    private func mapPopMoivesTouseDataModel(recivedData:MovieResult) ->FilmCardDataModel{
        FilmCardDataModel(
            id: recivedData.id,
            posterPath: recivedData.posterPath,
            title: recivedData.title,
            voteAvarage: recivedData.voteAverage,
            pop: recivedData.popularity,
            language: recivedData.originalLanguage,
            voteCount: recivedData.voteCount,
            isAdult: recivedData.adult,
            genreIds: recivedData.genreIDS, landscapeImage: recivedData.backdropPath ?? ""
        )
    }
}
