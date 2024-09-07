//
//  MainMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-05.
//

import SwiftUI
import Kingfisher

struct SingleMovieView: View {
    
    @StateObject private var singleMovieViewModel = SingleMovieViewModel()
    @State private var singleMovieData:SingleMovieModel? = nil
    @State private var changeImageQuality:Bool = false
    private var movieId:Int
   
    init(movieId:Int){
        self.movieId = movieId
    }
    var body: some View {
        VStack(spacing:.zero){
            ZStack(alignment:.bottomTrailing){
                ZStack(alignment:.topLeading){
                    mainImageView
                        .frame(height: UIScreen.main.bounds.height * 0.58)
                        .ignoresSafeArea()
                    BackButtonView()
                  .padding(.top,50)
                        .padding(.leading,20)
                }
            
                LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
                    .frame(height: 100)
                imageQualityChange
            }
            ZStack(alignment:.topLeading) {
                Rectangle()
                    .ignoresSafeArea()
                .frame(height: UIScreen.main.bounds.height * 0.45)
                detailsView
            }
        }.onAppear(perform: {
            Task{
                await singleMovieViewModel.mapSingleMovieDetals(movieId: movieId)
            }
        }).onReceive(singleMovieViewModel.$movieMainDeitails, perform: { newValue in
                self.singleMovieData = newValue
        }).navigationBarBackButtonHidden()
    }
}
extension SingleMovieView{
    private var detailsView:some View{
        ScrollView{
            VStack(alignment:.leading){
                TMDBRatingView
                nameTag
                relatedCategories
                    .padding(.bottom)
                movieOverView
            }.padding()
                .redacted(reason: singleMovieData == nil ? .placeholder : .privacy)
        }
    }
    private var mainImageView:some View{
        VStack{
            KFImage(URL(string: "\(String.posterBaseUrl(quality: "185"))\(singleMovieData?.posterPath ?? "place holder")"))
                .placeholder({  _ in
                    Image("background")
                        .resizable()
                        .scaledToFill()
                })
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
    private var nameTag:some View{
        VStack(alignment:.leading){
            Text(singleMovieData?.title.uppercased() ?? "place holder")
                .font(Font.custom("Montserrat-Bold", size: 25))
                .foregroundStyle(Color.white)
            Text(singleMovieData?.tagline.uppercased() ?? "place holder")
                .font(Font.custom("Montserrat-Regular", size: 14))
                .foregroundStyle(LinearGradient(colors: [.green,.cyan], startPoint: .leading, endPoint: .trailing))
        }
    }
    private var TMDBRatingView:some View{
        HStack(spacing:10){
            Text("TMDB \(String.averageFormatter(from: singleMovieData?.voteAverage ?? 0.0))")
                .font(.system(size: 12,weight: .medium))
                .foregroundStyle(Color.black)
                .padding(.horizontal,20)
                .padding(.vertical,5)
                .background(.mint)
                .cornerRadius(20)
            Image(systemName: "star.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20,height: 20)
                .foregroundStyle(Color.mint)
            Text("\(String.averageFormatter(from: singleMovieData?.voteAverage ?? 0.0))")
                .font(.system(size: 13,weight: .bold))
                .foregroundStyle(Color.mint)
            Text("(\(String.averageFormatter(from: (singleMovieData?.voteCount ?? 0))) reviews)")
                .font(.system(size: 13,weight: .medium))
                .foregroundStyle(Color.white)
            
        }
    }
    private var relatedCategories:some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(singleMovieData?.genres ?? [Genre(id: 1, name: "place holder")],id: \.id){ genre in
                    Text(genre.name)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                        .font(Font.custom("Montserrat-Regular", size: 14))
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(Color.green.opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }.scrollIndicators(.never)
            .scrollClipDisabled()
    }
    private var movieOverView:some View{
        Text(singleMovieData?.overview ?? "place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder ")
            .font(Font.custom("Montserrat-Regular", size: 14))
            .foregroundStyle(Color.white)
    }
    private var imageQualityChange:some View{
        HStack(spacing:.zero){
            Image(systemName: "photo.circle.fill")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30,height: 30)
                .padding(10)
                .foregroundStyle(.gray,.white)
                .onTapGesture {
                    self.changeImageQuality.toggle()
                }
//            Text("Quality")
//                .font(.system(size: 8))
//                .foregroundStyle(Color.white)
//                .fontWeight(.bold)
//                .padding(.trailing,5)
        }
    }
//    private var qualityString:String {
//        if changeImageQuality {
//            return "500"
//        }else{
//            return"185"
//        }
//    }
}

#Preview {
    SingleMovieView(movieId: 533535)
}
