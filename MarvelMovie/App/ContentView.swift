//
//  ContentView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import SwiftUI

struct ContentView: View {
    @State private var startApp:Bool = false
    @StateObject private var appStateManager = AppState()
    var body: some View {
        NavigationStack{
            SplashScreen(posterUrl: "")
                .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        startApp.toggle()
                    }
                })
                .navigationDestination(isPresented: $startApp) {
                  ApplicationBase()
                        .environmentObject(appStateManager)
                        .navigationBarBackButtonHidden()
                }
          
        }
    }
}

#Preview {
    ContentView()
}
