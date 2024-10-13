//
//  SingleFavMovieView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-10-01.
//

import SwiftUI
import Kingfisher

struct SingleFavMovieView: View {
   var singleFavMovie:FavMovieModelResult?
    
    var body: some View {
        HStack(alignment:.top){
            moviePosterView
            movieDetails
                .frame(maxWidth: .infinity,alignment: .leading)
        }.background(Color.clear)
    }
}
extension SingleFavMovieView{
    private var moviePosterView:some View{
        VStack{
            KFImage(URL(string: "\(String.posterBaseUrl(quality: "500"))\(singleFavMovie?.posterPath ?? "")"))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .aspectRatio(contentMode: .fit)
                .frame(width: 200,height: 200)
              
               
        }
    }
    private var movieDetails:some View{
        VStack(alignment: .leading){
            Text(singleFavMovie?.title ?? "")
                .font(Font.custom("Montserrat-Bold", size: 15))
                .foregroundStyle(Color.white)
            Text("TMDB \(String.averageFormatter(from: singleFavMovie?.voteAverage ?? 0.0))")
                .font(.system(size: 12,weight: .bold))
                .foregroundStyle(Color.black)
                .padding(.horizontal,20)
                .padding(.vertical,5)
                .background(.mint)
                .cornerRadius(20)
//            categories(genre: singleFavMovie)
            
        }
    }
    private func categories(genre:[Genre]) ->some View{
        HStack{
            ForEach(genre,id: \.id) { genre in
                Text(genre.name)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .font(Font.custom("Montserrat-Regular", size: 14))
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(Color.blue.opacity(0.22))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        
    }
}

#Preview {
    SingleFavMovieView(singleFavMovie:nil)
}
