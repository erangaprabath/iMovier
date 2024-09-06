//
//  PopularMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-06.
//

import SwiftUI
import Kingfisher

struct PopularMovieView: View {
    @StateObject var popularViewModel:SinglePopularMovieViewModel
    
    init(dashboardViewModel: DashboardViewModel) {
        _popularViewModel = StateObject(wrappedValue: SinglePopularMovieViewModel(moviewViewModel: dashboardViewModel))
    }
    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing:.zero){
                ForEach(popularViewModel.mapPopMovie(),id: \.id) {singlePopMovie in
                    singleMoivePosterView(imageUrl: singlePopMovie.landscapeImage)
                       
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scrollTransition(axis:.horizontal){
                            content,phase in
                            content
//                                .rotation3DEffect(.degrees(phase.value * -30.0), axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(
                                    x:phase.isIdentity ? 1 : 0.8,
                                    y:phase.isIdentity ? 1 : 0.8
                                )
                                
                        }.padding(.leading ,10)
                       
                }
            }
        }.scrollTargetBehavior(.viewAligned)
            .scrollTargetLayout()
            
    }
}
extension PopularMovieView{
    private func singleMoivePosterView (imageUrl:String) ->some View{
        KFImage(URL(string: "\(String.posterBaseUrl(quality: "500"))\(imageUrl)"))
            .resizable()
            .scaledToFill()
            .frame(width: 300,height: 200)
            
            
    }
}
#Preview {
    PopularMovieView(dashboardViewModel: DashboardViewModel())
}
//KFImage(URL(string: "\(String.posterBaseUrl(quality: "185"))\(popularViewModel.mapPopMovie().first?.landscapeImage ?? "")"))
