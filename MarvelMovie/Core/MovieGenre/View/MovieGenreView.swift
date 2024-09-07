//
//  MovieGenreView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import SwiftUI

struct MovieGenreView: View {
    @StateObject private var movieGenreViewModel:MovieGenreViewModel
    @State private var movieGenre:MovieGenreModel? = nil
    @State private var selected:Int = 1
    init(dashboardViewModel:DashboardViewModel){
        _movieGenreViewModel = StateObject(wrappedValue: MovieGenreViewModel(dashBoardViewModel: dashboardViewModel))
    }
    
    var body: some View {
        VStack{
            ScrollViewReader(content: { proxy in
            ScrollView(.horizontal){
                HStack{
                    ForEach(movieGenre?.genres ?? [],id:\.id){ singleGenre in
                        singleGenreView(genre: singleGenre.name, isSelect: singleGenre.id == selected)
                            .id(selected)
                            .onTapGesture {
                                selected = singleGenre.id
                                movieGenreViewModel.getFilterdFilms(genreId: singleGenre.id)
                                
                                
                            }
                    }
                }
            }.scrollIndicators(.hidden)
            })
        
        }.onReceive(movieGenreViewModel.$genreData, perform: { newValues in
            movieGenre = newValues
        })
    
      
    }
}
extension MovieGenreView{
    private func singleGenreView(genre:String,isSelect:Bool)->some View{
        HStack(spacing:.zero){
//            if isSelect{
//               Rectangle()
//                    .foregroundStyle(Color.red)
//                    .frame(width: 4,height: 20)
//            }
            Text(genre)
                .font(.system(size: 16,weight: .bold,design: .rounded))
                .foregroundStyle(isSelect ? Color.white : Color.white)
        }.padding(10)
        .background(isSelect ? Color.mint : Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MovieGenreView(dashboardViewModel: DashboardViewModel())
}
