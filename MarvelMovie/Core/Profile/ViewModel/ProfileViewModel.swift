//
//  ProfileViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

class ProfileViewModel:ObservableObject{
    
    private let networkManger = NetworkManager<networkEndpoint>()
    private let profileData:TmdbDataDownloadServices
    @Published var profile:ProfileModel? = nil
    
    init() {
        self.profileData = TmdbDataDownloadServices(networkmanager: networkManger)
        Task{ await mapUserProfile() }
    }
    
    func mapUserProfile() async{
        Task{ @MainActor [weak self] in
            let profileData = await self?.profileData.dwonloadUsreDetails(userId: 21476694)
            switch profileData {
                case .success(let profileData):
                    self?.profile = profileData
                    print(profileData.avatar.tmdb.avatarPath ?? "")
                case .failure(let failure):
                    print("Fetch data faild \(failure.localizedDescription)")
                case.none:
                    print(APIError.unknownError)
            }
        }
    }
}
