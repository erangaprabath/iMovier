//
//  ProfileScreenViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-10-01.
//

import Foundation

class ProfileScreenViewModel:ObservableObject{
    let networkmanger = NetworkManager<networkEndpoint>()
    let tmdbServices:TmdbDataDownloadServices
    @Published private(set) var favMovieList:[FavMovieModelResult] = []
    
    init(){
        self.tmdbServices = TmdbDataDownloadServices(networkmanager: networkmanger)
    }
    
    @MainActor
    func getFavMovieList()async{
        Task{
            let favMovieList = await tmdbServices.getFavMovieList()
            switch favMovieList {
                case .success(let favMovieList):
                    self.favMovieList = favMovieList.results
                case .failure(let failure):
                    print(failure.localizedDescription)
            }
        }
    }
}
