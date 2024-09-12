//
//  PopularMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-06.
//

import SwiftUI
import Kingfisher

struct PopularMovieView: View {
    @StateObject var popularViewModel:PopularMovieViewModel
    @State private var popularMovies:[FilmCardDataModel] = []
    @Binding var movieId:Int?
    @Binding var viewMovie:Bool
    
    
    init(dashboardViewModel: DashboardViewModel,movieId:Binding<Int?>,viewMovie:Binding<Bool>) {
        _popularViewModel = StateObject(wrappedValue: PopularMovieViewModel(moviewViewModel: dashboardViewModel))
        _movieId = movieId
        _viewMovie = viewMovie
    }
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack(spacing:.zero){
                ForEach(popularMovies,id: \.id) {singlePopMovie in
                    singleMoivePosterView(singleMoive: singlePopMovie)
                        .onTapGesture {
                            viewMovie.toggle()
                            movieId = singlePopMovie.id
                        }
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 16)
                        .scrollTransition(axis:.horizontal){
                            content,phase in
                            content
                                .opacity(phase.isIdentity ? 1 : 0.2)
                            
                                .rotation3DEffect(.degrees(phase.value * -30.0), axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(
                                    x:phase.isIdentity ? 1 : 0.5,
                                    y:phase.isIdentity ? 1 : 0.5
                                )
                            
                        }
                }
            }.scrollTargetLayout()
        }.scrollTargetBehavior(.viewAligned)
            .onReceive(popularViewModel.$popularMovies, perform: { newValue in
                popularMovies = newValue
            })
    }
}
extension PopularMovieView{
    private func singleMoivePosterView (singleMoive:FilmCardDataModel) ->some View{
        VStack{
            VStack(alignment: .leading){
                KFImage(URL(string: "\(String.posterBaseUrl(quality: "500"))\(singleMoive.landscapeImage)"))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                
//                Text("\(singleMoive.title)")
//                    .textCase(.uppercase)
//                    .font(Font.custom("Montserrat-Bold", size: 14))
//                    .foregroundStyle(Color.mint)
                
            }
        }
    }
}
#Preview {
    PopularMovieView(dashboardViewModel: DashboardViewModel(), movieId: .constant(53463), viewMovie: .constant(false))
}

