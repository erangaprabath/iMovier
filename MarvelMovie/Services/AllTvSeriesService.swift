//
//  AllTvSeriesService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

actor AllTvSeriesService{
    
    private var networkManager:NetworkManager<networkEndpoint>
    init(networkManager: NetworkManager<networkEndpoint>) {
        self.networkManager = networkManager
    }
    
    func donwloadAllTvSeries(pageNo:Int) async -> Result<AllTvSeriesModel,Error>{
        let allTvSeries = networkEndpoint.getAllTvSeriesListByPage(pageNo: pageNo, isAdult: true)
        do{
            let fetchData:AllTvSeriesModel = try await networkManager.downloadData(endpoints: allTvSeries)
            return.success(fetchData)
        }catch{
            return .failure(error)
        }
    }
}
