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
                            .containerRelativeFrame(.horizontal, count: /*@START_MENU_TOKEN@*/4/*@END_MENU_TOKEN@*/, spacing: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                            .id(selected)
                            .onTapGesture {
                                selected = singleGenre.id
                                movieGenreViewModel.getFilterdFilms(genreId: singleGenre.id)
                                
                                
                            }
                    }
                } .scrollTargetLayout()
            }.scrollIndicators(.hidden)
                    .scrollTargetBehavior(.paging)
            })
        
        }.onReceive(movieGenreViewModel.$genreData, perform: { newValues in
            movieGenre = newValues
        })
    
      
    }
}
extension MovieGenreView{
    private func singleGenreView(genre:String,isSelect:Bool)->some View{
        HStack(spacing:.zero){
            Text(genre)
                .font(.system(size: 13,weight: .regular,design: .rounded))
                .foregroundStyle(isSelect ? Color.mint : Color.gray)
        }.padding(5)
//            .background(isSelect ? Color.mint.opacity(0.99) : Color.mainBackground.opacity(0.8))
//        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    MovieGenreView(dashboardViewModel: DashboardViewModel())
}
