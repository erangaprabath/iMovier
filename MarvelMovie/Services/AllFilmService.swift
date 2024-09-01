//
//  AllFilmService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import Foundation

actor AllFilmService{
    private var networkmanger:NetworkManager<networkEndpoint>
    
    init(networkmanger: NetworkManager<networkEndpoint>) {
        self.networkmanger = networkmanger
    }
    
    func downloadAllFilmData(pageNo:Int) async -> Result<MovieModel,Error>{
     
        let allMovies = networkEndpoint.getAllMovieListByPage(pageNo: pageNo, isAdult: false, includeVideo: true)
        do {
            let fetchData:MovieModel = try await networkmanger.downloadData(endpoints: allMovies)
            return .success(fetchData)
            
        }catch{
            return.failure(error)
        }
        
    }
}
