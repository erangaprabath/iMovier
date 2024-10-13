//
//  ProfileMainScreen.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-18.
//

import SwiftUI
import Kingfisher

struct ProfileMainScreen: View {
    @StateObject private var profileViewModel = ProfileScreenViewModel()
    @State private var favMovieList:[FavMovieModelResult] = []
    @State private var toSingleMovieView:Bool = false
    @State private var singleMovieId:Int = 0
    
    var body: some View {
        VStack{
            userDetailView
                .padding()
                .background(.cyan.opacity(0.2))
               
           
            List{
                Section {
                    Text("favorite movie list")
                        .font(Font.custom("Montserrat-Bold", size: 20))
                        .textCase(.uppercase)
                        .foregroundStyle(Color.white)
                }    .listRowBackground(Color.clear)
                ForEach(favMovieList,id: \.id){ singleFavMoie in
                    
                    SingleFavMovieView(singleFavMovie: singleFavMoie)
                        .onTapGesture {
                            toSingleMovieView.toggle()
                            singleMovieId = singleFavMoie.id
                        }
                    
                        .listRowBackground(Color.clear)
                }
            }.listStyle(.plain)
                .navigationDestination(isPresented: $toSingleMovieView) {
                    SingleMovieView(movieId: singleMovieId, isMovie: false, networkManger: profileViewModel.networkmanger, tmdbServiceLayer: profileViewModel.tmdbServices)
                }
        }.foregroundStyle(.white)
        .background(
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                Color.black.opacity(0.9)
                    .ignoresSafeArea()
            })
        .task {
            await profileViewModel.getFavMovieList()
        }.onReceive(profileViewModel.$favMovieList) { recivedNewValues in
            self.favMovieList = recivedNewValues
        }
    }
}

extension ProfileMainScreen {
    private var userDetailView:some View{
        HStack{
            ProfileSection(slideButton: false, sideMenuOpen: .constant(false))
                .environmentObject(ProfileViewModel(dashboardViewModel: DashboardViewModel()))
        }
    }
//    private var userProfileImageview:some View{
//        VStack{
//            KFImage(URL(string: "https://image.tmdb.org/t/p/w185\(profileData?.avatar.tmdb.avatarPath ?? "")"))
//                .placeholder({ Progress in
//                    Image(systemName: "person.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                        .foregroundStyle(.white,.mint)
//                        .frame(width: 60,height: 60)
//                })
//                .resizable()
//                .scaledToFit()
//                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//                .frame(width: 60,height: 60)
//        }
//    }
}
#Preview {
    ProfileMainScreen()
        .environmentObject(ProfileViewModel(dashboardViewModel: DashboardViewModel()))
}
