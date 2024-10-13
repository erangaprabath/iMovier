//
//  ProfileViewModel.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import Foundation

class ProfileViewModel:ObservableObject{

    private let dashboradViewModel:DashboardViewModel
    @Published var profile:ProfileModel? = nil
    
    init(dashboardViewModel:DashboardViewModel) {
        self.dashboradViewModel = dashboardViewModel
        _ = Task{
            await mapUserProfile()
        }
    }
    
    private func mapUserProfile() async{
        Task{ @MainActor [weak self] in
            let profileData = await self?.dashboradViewModel.allFilmService.dwonloadUsreDetails(userId: 21476694)
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
