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
    
    func downloadSingleMovieData(movieID:Int) async -> Result<SingleMovieModel,APIError>{
        let apiEndPoint = networkEndpoint.getMovieByMovieId(moiveID: movieID)
        do{
            let fetchData:SingleMovieModel = try await networkManger.downloadData(endpoints: apiEndPoint)
            return .success(fetchData)
        }catch{
            return.failure(APIError.decodingError(error: error))
        }
    }
}
