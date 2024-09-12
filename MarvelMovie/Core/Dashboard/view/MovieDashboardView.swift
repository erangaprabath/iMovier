//
//  MovieDashboardView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import SwiftUI

struct MovieDashboardView: View {
    @State private var currentIndex:Int? = 0
    @State private var dashboardViewModel = DashboardViewModel()
    @State private var movieData:[FilmCardDataModel] = []
    @State private var tvSeriesData:[FilmCardDataModel] = []
    private let placeHolderData:MoviePlaceholder = MoviePlaceholder()
    @State private var singleMovieView:Bool = false
    @State private var selectedMoiveID:Int? = nil
    @State private var appearedPopMovieId:Int = 0
    @State private var isTvSeries:Bool = false
    var isSearch:Bool = false
    @State private var searchText:String = ""
    var body: some View {
        VStack(alignment: .leading){
          ProfileSection()
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
            MovieGenreView(dashboardViewModel: dashboardViewModel)
                .padding(5)
         
            List{
                Section(section: "Popular")
                    .listRowBackground(Color.clear)
                popMovieSection
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                Section(section: "Movies")
                    .listRowBackground(Color.clear)
                movieSection
                Section(section: "TV Shows")
                    .listRowBackground(Color.clear)
                tvSeriesSection
            }.scrollIndicators(.never)
                .listStyle(.plain)
                .searchable(text: $searchText,prompt: "Search")
                .foregroundStyle(Color.white)
               
            
        }.background(
            ZStack{ 
               
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                Color.black.opacity(0.97)
                .ignoresSafeArea()
//
            })
        .task {
            dashboardViewModel.manageDataBinding()
        }
        .navigationDestination(isPresented: $singleMovieView) {
            SingleMovieView(movieId:selectedMoiveID ?? 0, isMovie: isTvSeries)
        }.onDisappear(perform: {
            dashboardViewModel.cancelTasks()
        })
       
    }
}
extension MovieDashboardView{
    private var movieSection:some View{
            VStack{
                ScrollView(.horizontal){
                    LazyHStack(){
                        ForEach(movieData,id:\.id){ singleMovie in
                            FilmCardView(singleMovie:singleMovie)
                               
                                .redacted(reason: !dashboardViewModel.viewIsLoaded ? .placeholder :.privacy)
                                .onTapGesture {
                                    isTvSeries = false
                                    selectedMoiveID = singleMovie.id
                                    if selectedMoiveID != nil{
                                        singleMovieView = true
                                    }
                                }.onAppear(perform: {
                                    if singleMovie.id == dashboardViewModel.movieDataSet.last?.id{
                                        dashboardViewModel.loadMoreData(isTvSeries: true)
                                    }
                                    
                                })
                        }
                    }
                }.scrollTargetBehavior(.viewAligned)
                .scrollTargetLayout()
                .scrollClipDisabled()
            } .onReceive(dashboardViewModel.$movieDataSet, perform: { newValues in
                self.movieData = newValues
            })
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    private var tvSeriesSection:some View{
            VStack{
                ScrollView(.horizontal){
                    LazyHStack{
                        ForEach(tvSeriesData,id:\.id){ singleMovie in
                            FilmCardView(singleMovie:singleMovie)
                                .redacted(reason: !dashboardViewModel.viewIsLoaded ? .placeholder :.privacy)
                                .onTapGesture {
                                    isTvSeries = true
                                    selectedMoiveID = singleMovie.id
                                    singleMovieView = true
                                }.onAppear(perform: {
                                    if singleMovie.id == dashboardViewModel.tvSeriesDataSet.last?.id{
                                        dashboardViewModel.loadMoreData(isTvSeries: false)
                                    }
                                })
                        }
                    }
                }.scrollTargetBehavior(.viewAligned)
                .scrollTargetLayout()
                .scrollClipDisabled()
            } .onReceive(dashboardViewModel.$tvSeriesDataSet, perform: { newValues in
                self.tvSeriesData = newValues
            })
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
    }
    private func Section(section:String)->some View{
        VStack{
            Text(section)
                .foregroundStyle(Color.white)
                .font(Font.custom("Montserrat-Regular", size: 16))
                .fontWeight(.regular)
        }
    }
    private var popMovieSection:some View{
        VStack{
            PopularMovieView(dashboardViewModel: dashboardViewModel, movieId: $selectedMoiveID,viewMovie: $singleMovieView)
               
        }.scrollClipDisabled()
    }
}
#Preview {
    MovieDashboardView()
}


