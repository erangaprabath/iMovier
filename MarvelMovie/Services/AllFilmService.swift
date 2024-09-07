//
//  AllFilmService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

actor AllFilmService{
    private var networkManger:NetworkManager<networkEndpoint>
    
    init(networkmanger: NetworkManager<networkEndpoint>) {
        self.networkManger = networkmanger
    }
    
    func downloadAllFilmData(pageNo:Int) async -> Result<MovieModel,Error>{
     
        let allMovies = networkEndpoint.getAllMovieListByPage(pageNo: pageNo, isAdult: true, includeVideo: true)
        do {
            let fetchData:MovieModel = try await networkManger.downloadData(endpoints: allMovies)
            return .success(fetchData)
            
        }catch{
            return.failure(error)
        }
        
    }
}
