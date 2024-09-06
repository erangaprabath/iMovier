//
//  GetSingleMovieService.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-04.
//

import Foundation

actor GetSingleMovieService{
    
    private let networkManger:NetworkManager<networkEndpoint>
    
    init(networkManger: NetworkManager<networkEndpoint>) {
        self.networkManger = networkManger
    }
    
    func downloadSingleMovieData() async -> String{
        return "Hello my boy"
    }
}
