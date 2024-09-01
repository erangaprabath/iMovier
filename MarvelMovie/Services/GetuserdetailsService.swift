//
//  GetuserdetailsService.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

actor GetuserdetailsService {
    
    private var networkManger:NetworkManager<networkEndpoint>
    
    init(networkManger: NetworkManager<networkEndpoint>) {
        self.networkManger = networkManger
    }
    
    func dwonloadUsreDetails(userId:Int) async -> Result<ProfileModel,APIError>{
        let getUserEndPoint = networkEndpoint.getUserProfile(userId: userId)
        do {
            let fetchData:ProfileModel = try await networkManger.downloadData(endpoints: getUserEndPoint)
            return .success(fetchData)
        }catch{
            return .failure(APIError.decodingError(error: error))
        }
    }
}
