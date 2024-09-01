//
//  DashboardViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

class DashboardViewModel:ObservableObject{
    
    @Published var errors:Error? = nil
    @Published var viewIsLoaded:Bool = false
    @Published var movieDataSet:[FilmCardDataModel] = []
    @Published var tvSeriesDataSet:[FilmCardDataModel] = []
    private var moviePageNo:Int = 1
    private var tvSeriesPageNo:Int = 1
    
    private let networkManager = NetworkManager<networkEndpoint>()
    
    private let allFilmService:AllFilmService
    private let allTvSeriesService:AllTvSeriesService
    
    init(){
        self.allFilmService = AllFilmService(networkmanger: networkManager)
        self.allTvSeriesService = AllTvSeriesService(networkManager: networkManager)
        manageDataBinding()
    }
    
    func manageDataBinding(){
        viewIsLoaded = false
        mapMovies()
        mapTvSeries()
        viewIsLoaded = true
    }
    func loadMoreData(isMovie:Bool){
        if isMovie{
            moviePageNo = moviePageNo + 1
            mapMovies()
        }else{
            tvSeriesPageNo = tvSeriesPageNo + 1
            mapTvSeries()
        }
    }

   private func mapMovies(){
        
        Task{ @MainActor in
          
            let movieData = await self.allFilmService.downloadAllFilmData(pageNo: moviePageNo)
            switch movieData{
                case .success(let recievedMovieData):
                    let newMovies = recievedMovieData.results.map { mapMovieViewData(recivedData: $0) }
                    self.movieDataSet.append(contentsOf: newMovies)
                    print(recievedMovieData)
                case .failure(let failure):
                    viewIsLoaded = false
                    self.errors = failure
                    print(errors?.localizedDescription ?? [])
                  
            }
        }
    }
    private func mapTvSeries(){
        Task{ @MainActor in
            let tvSeriesData = await self.allTvSeriesService.donwloadAllTvSeries(pageNo: tvSeriesPageNo)
            switch tvSeriesData {
                case .success(let recivedTvSeriesData):
                    let newTvSeries = recivedTvSeriesData.results.map({mapTvSeriesViewData(recivedData: $0)})
                    self.tvSeriesDataSet.append(contentsOf: newTvSeries)
                case .failure(let failure):
                    self.errors = failure
                    print(errors?.localizedDescription ?? [])
            }
            
        }
    }
    
    private func mapTvSeriesViewData(recivedData: AllTvSeriesModelResult) -> FilmCardDataModel{
        FilmCardDataModel(
            id: recivedData.id,
            posterPath: recivedData.posterPath,
            title: recivedData.name,
            voteAvarage: recivedData.voteAverage,
            pop: recivedData.popularity,
            language: recivedData.originalLanguage,
            voteCount: recivedData.voteCount, isAdult: recivedData.adult
        )
    }
    
    private func mapMovieViewData(recivedData:MovieResult) -> FilmCardDataModel{
        FilmCardDataModel(
            id: recivedData.id,
            posterPath: recivedData.posterPath,
            title: recivedData.title,
            voteAvarage: recivedData.voteAverage,
            pop: recivedData.popularity,
            language: recivedData.originalLanguage,
            voteCount: recivedData.voteCount, isAdult: recivedData.adult
        )
    }
}
