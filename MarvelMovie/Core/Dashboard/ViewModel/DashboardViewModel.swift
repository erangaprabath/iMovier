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
    private var isFilterActive:Bool = false
    private var genreId:Int = 0
    let networkManager = NetworkManager<networkEndpoint>()
    let allFilmService:TmdbDataDownloadServices
    var tasks:[Task<Void ,Never>] = []
    
    
    init(){
        self.allFilmService = TmdbDataDownloadServices(networkmanager: networkManager)
    }
    func cancelTasks(){
        tasks.forEach({$0.cancel()})
        print("Task has been canceled")
        tasks = []
        
    }
    
    func manageDataBinding(){
        viewIsLoaded = false
        Task{
            await mapMovies()
            await mapTvSeries()
            viewIsLoaded = true
        }
    }
    func loadMoreData(isTvSeries:Bool){
        if isTvSeries{
            moviePageNo = moviePageNo + 1
            Task{ await mapMovies() }
        }else{
            tvSeriesPageNo = tvSeriesPageNo + 1
            Task{ await  mapTvSeries() }
        }
    }

   private func mapMovies()async{
        Task{ @MainActor in
            let movieData = await self.allFilmService.downloadAllFilmData(pageNo: moviePageNo)
            switch movieData{
                case .success(let recievedMovieData):
                    let newMovies = recievedMovieData.results.map { mapMovieViewData(recivedData: $0) }
                    if isFilterActive{
                        let filtereddMovie = newMovies.filter({$0.genreIds.contains(genreId)})
                        self.movieDataSet.append(contentsOf: filtereddMovie)
                    }else{
                        self.movieDataSet.append(contentsOf: newMovies)
                    }
                case .failure(let failure):
                    viewIsLoaded = false
                    self.errors = failure
                    print(errors?.localizedDescription ?? [])
                  
            }
        }
    }
    private func mapTvSeries() async{
        Task{ @MainActor in
            let tvSeriesData = await self.allFilmService.donwloadAllTvSeries(pageNo: tvSeriesPageNo)
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
            posterPath: recivedData.posterPath ?? "",
            title: recivedData.name ?? "",
            voteAvarage: recivedData.voteAverage,
            pop: recivedData.popularity,
            language: recivedData.originalLanguage,
            voteCount: recivedData.voteCount, 
            isAdult: recivedData.adult,
            genreIds: recivedData.genreIDS, landscapeImage: recivedData.backdropPath ?? ""
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
            voteCount: recivedData.voteCount, 
            isAdult: recivedData.adult,
            genreIds: recivedData.genreIDS, landscapeImage: recivedData.backdropPath ?? ""
        )
    }
    
    func filterMovieByGenreId(genreId:Int){
        self.isFilterActive = true
        self.genreId = genreId
        let filtedMovies = self.movieDataSet.filter({$0.genreIds.contains(genreId)})
        _ = self.tvSeriesDataSet.filter({$0.genreIds.contains(genreId)})
        if filtedMovies.isEmpty{
            loadMoreData(isTvSeries: true)
        }
        self.movieDataSet = filtedMovies
        print("FILTER BY GENRE ID \(genreId) \(filtedMovies)")
//        self.tvSeriesDataSet = filtedTvSeries
        
    }
}
