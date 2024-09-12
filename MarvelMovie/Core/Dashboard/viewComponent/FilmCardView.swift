//
//  FilmCardView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import SwiftUI
import Kingfisher

struct FilmCardView: View {
    var singleMovie:FilmCardDataModel
    var body: some View {
        VStack(alignment:.center){
            moviePostersReviewAndNameView
                .padding(.top,5)
                .padding(.horizontal,5)
                .padding(.bottom,40)
            Text(singleMovie.title)
                .foregroundStyle(Color.white)
                .lineLimit(1)
                .font(.system(size: 12,weight: .bold))
                .padding(.bottom,5)
                .frame(width: 100)
            movieDetails
                .padding(.bottom,20)
          
        }
        .padding(5)
        .background(Color.mainBackground)
        .cornerRadius(10)
        
    }
}

extension FilmCardView{
    private var moviePostersReviewAndNameView:some View{
        ZStack(alignment:.bottomLeading){
            cardViewMainImage(cornerRadius: 10,heigth:  150,width: 100)
            secondaryPosterAndName
                .offset(x:10,y:30)
            
        }
    }
    
    private func cardViewMainImage(cornerRadius:CGFloat,heigth:CGFloat,width:CGFloat) -> some View{
        ZStack{
            KFImage(URL(string: "https://image.tmdb.org/t/p/w185\(singleMovie.posterPath)"))
                .resizable()
                .frame(width: width,height: heigth)
                .background(Color.gray)
                .cornerRadius(cornerRadius)
                .scaledToFill()
              
        }
    }
    private var secondaryPosterAndName:some View{
        HStack(alignment:.bottom,spacing:5){
                cardViewMainImage(cornerRadius: 5, heigth: 50, width: 40)
                .shadow(color: .white,radius: 1)
            VStack(alignment:.leading,spacing: 5){
                if singleMovie.isAdult{
                    KFImage(URL(string: "https://static.tvtropes.org/pmwiki/pub/images/rated_rsvg_red.png"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                }
                HStack(spacing:.zero){
                    Text("TMDB  \(formattedVoteAverage(singleMovie.voteAvarage))")
                        .font(.system(size: 5,weight: .bold))
                        .foregroundStyle(Color.white)
                        .padding(2)
                        .background(LinearGradient(colors: [.cyan,.green], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(8)
                    
                }
            }
   
        }.background(Color.clear)
    }
    private var movieDetails:some View{
        HStack(spacing:5){
            singleDetail(title: "Popu", detail: "\(formattedVoteAverage(singleMovie.pop))")
            singleDetail(title: "Lang", detail: singleMovie.language.uppercased())
            singleDetail(title: "Votes", detail: "\(singleMovie.voteCount)")
          
        }
    }
    private func singleDetail(title:String,detail:String)->some View{
        VStack(spacing:10){
            Text(title)
                .font(.system(size: 8))
                .foregroundStyle(Color.gray)
            Text(detail)
                .foregroundStyle(Color.white)
                .font(.system(size: 7))
                .fontWeight(.bold)
        }
    }
    private func formattedVoteAverage(_ voteAverage: Double) -> String {
           return String(format: "%.2f", voteAverage)
       }
}


#Preview {
//    FilmCardView(singleMovie: <#MoviewResult#>, imageUrl: "https://i.redd.it/i6fuvkjuga7c1.jpeg", random: true)
    MovieDashboardView(isSearch: true)
}
