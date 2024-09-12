//
//  ApplicationBase.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-12.
//

import SwiftUI

struct ApplicationBase: View {
    @EnvironmentObject private var appStateManager:AppState
    var body: some View {
        ZStack(alignment:.bottom){
            switch appStateManager.selectedTab{
                case "Home":
                    MovieDashboardView()
                case "Search":
                   MovieDashboardView()
                    
                default:
                    MovieDashboardView()
            }
       
            BottomNavigationbar()
                .environmentObject(appStateManager)
                .frame(maxWidth: .infinity)
                .padding(.top)
                .background(Color.black)
        }
    }
}

#Preview {
    ApplicationBase()
        .environmentObject(AppState())
}
