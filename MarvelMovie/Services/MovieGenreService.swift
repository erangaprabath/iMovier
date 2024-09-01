//
//  MovieGenreService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

actor MovieGenreService{
    
    private var networkMager:NetworkManager<networkEndpoint>
    
    init(networkMager: NetworkManager<networkEndpoint>) {
        self.networkMager = networkMager
    }
    
    func downloadMovieGenre() async -> Result<MovieGenreModel, APIError>{
        let movieGenreEndpoint = networkEndpoint.getMovieGenre
        do{
            let fetchData:MovieGenreModel = try await networkMager.downloadData(endpoints: movieGenreEndpoint)
            return .success(fetchData)
        }catch{
            return .failure(APIError.decodingError(error: error))
        }
    }
}
