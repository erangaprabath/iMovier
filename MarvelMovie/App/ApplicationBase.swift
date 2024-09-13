//
//  ApplicationBase.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-12.
//

import SwiftUI

struct ApplicationBase: View {
    @EnvironmentObject private var appStateManager:AppState
    @StateObject private var dashboardViewModel = DashboardViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()
   
    var body: some View {
        ZStack(alignment:.bottom){
            switch appStateManager.selectedTab{
                case "Home":
                    MovieDashboardView(profileViewModel: profileViewModel)
                        .environmentObject(dashboardViewModel)
                        .transition(.move(edge: .leading))
                case "Search":
                    MovieDashboardView(profileViewModel: profileViewModel)
                        .environmentObject(dashboardViewModel)
                        .transition(.move(edge: .leading))
                default:
                    MovieDashboardView(profileViewModel: profileViewModel)
                        .environmentObject(dashboardViewModel)
                        .transition(.move(edge: .leading))
            }
       
            BottomNavigationbar()
                .environmentObject(appStateManager)
                .frame(maxWidth: .infinity)
                .padding(.top)
                .background(Color.black)
        }.background(Color.black)
    }
}

#Preview {
    ApplicationBase()
        .environmentObject(AppState())
}
