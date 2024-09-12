//
//  BottomNavigationbar.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-07.
//

import SwiftUI

struct BottomNavigationbar: View {
    @EnvironmentObject private var appStateManager:AppState
    var body: some View {
        HStack(spacing:30){
            singleTabView(iconName: "house", tabName: "Home",isTabed: appStateManager.selectedTab == "Home")
            singleTabView(iconName: "magnifyingglass", tabName: "Search",isTabed:appStateManager.selectedTab == "Search")
            singleTabView(iconName: "gear", tabName: "Settings",isTabed:appStateManager.selectedTab == "Settings")
            singleTabView(iconName: "person", tabName: "Profile",isTabed: appStateManager.selectedTab == "Profile")
        }
    }
}
extension BottomNavigationbar{
    private func singleTabView(iconName:String,tabName:String,isTabed:Bool) -> some View{
        HStack{
            Image(systemName: iconName)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundStyle(Color.white)
                .frame(width: 20,height: 20)
                .fontWeight(.semibold)
            if isTabed{
                Text(tabName)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                    .opacity(isTabed ? 1: 0)
            }
        }.padding(10)
        .background(isTabed ? Color.mint : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .onTapGesture {
            withAnimation {
                appStateManager.selectedTab = tabName
            }
  
        }
    }
}

#Preview {
    BottomNavigationbar()
        .environmentObject(AppState())
}
