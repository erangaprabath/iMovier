//
//  MovieGenreView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import SwiftUI

struct MovieGenreView: View {
    @StateObject private var movieGenreViewModel = MovieGenreViewModel()
    @State private var movieGenre:MovieGenreModel? = nil
    @State private var selected:Int = 1
 
    var body: some View {
        VStack{
            ScrollView(.horizontal){
                HStack{
                    ForEach(movieGenre?.genres ?? [],id:\.id){ singleGenre in
                        singleGenreView(genre: singleGenre.name, isSelect: singleGenre.id == selected)
                            .onTapGesture {
                                selected = singleGenre.id
                            }
                            .onAppear(){
                                selected = singleGenre.id
                            }
                            .padding()
                        
                    }
                }
            }
        
        }.onReceive(movieGenreViewModel.$genreData, perform: { newValues in
            movieGenre = newValues
        })
    
      
    }
}
extension MovieGenreView{
    private func singleGenreView(genre:String,isSelect:Bool)->some View{
        VStack{
            Text(genre)
                .font(.system(size: 16,weight: .medium,design: .rounded))
                .foregroundStyle(isSelect ? Color.yellow : Color.white)
        }
    }
}

#Preview {
    MovieGenreView()
}
