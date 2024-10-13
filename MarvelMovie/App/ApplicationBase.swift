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

   
    var body: some View {
        VStack(){
            switch appStateManager.selectedTab{
                case "Home":
                    MovieDashboardView()
                        .padding(.bottom)
                        .environmentObject(dashboardViewModel)
               
//                case "Search":
//                    MovieDashboardView()
//                        .environmentObject(dashboardViewModel)
//                        .transition(.move(edge: .leading))
                case "Profile":
                    ProfileMainScreen()
                      
                default:
                    Rectangle()
                        .frame(maxHeight: .infinity)
                
                 
            }
       
            BottomNavigationbar()
                .environmentObject(appStateManager)
                .frame(maxWidth: .infinity)
           
                .background(Color.black)
        }.background(Color.black)
    }
}

#Preview {
    ApplicationBase()
        .environmentObject(AppState())
}
