//
//  MainMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-05.
//

import SwiftUI
import Kingfisher

struct SingleMovieView: View {
    
    @StateObject private var singleMovieViewModel:SingleMovieViewModel
    @State private var textExpand:Bool = false
    @State private var viewExpand:Bool = false
    @State private var animate:Bool = false
    @State private var animatorDisplay:Bool = true
    @State private var singleMovieData:SingleMovieAndTvSeiresModel? = nil
    @State private var changeImageQuality:Bool = false
    @State private var isFavorite:Bool = false
    private var movieId:Int
    private var isMovie:Bool
    
    init(movieId:Int,isMovie:Bool,networkManger:NetworkManager<networkEndpoint>,tmdbServiceLayer:TmdbDataDownloadServices){
        self.movieId = movieId
        self.isMovie = isMovie
        _singleMovieViewModel = StateObject(wrappedValue: SingleMovieViewModel(networkManager: networkManger, tmdbServiceLayer: tmdbServiceLayer))
    }
    var body: some View {
        ZStack (alignment: .topLeading){
            VStack(spacing:.zero){
                mainImageView
                    .background(Color.black)
                    detailsView
                    .background(Color.black)
                    .onTapGesture {
                        withAnimation {
                            animatorDisplay = false
                            viewExpand.toggle()
                        }
                        
                    }
            }
            HStack{
                BackButtonView()
                Spacer()
                favoirte
            } .padding(.top,50)
            .padding(.horizontal,20)
        }.task{
            print(isMovie.description)
            await singleMovieViewModel.mapSingleMovieDetals(movieId: movieId, isMovie: isMovie)
            
        }.onReceive(singleMovieViewModel.$movieMainDeitails, perform: { newValue in
            self.singleMovieData = newValue
        }).navigationBarBackButtonHidden()
            .ignoresSafeArea()
    }
}
extension SingleMovieView{
    private var detailsView:some View{
        ScrollView{
            VStack(alignment:.leading){
                if animatorDisplay{
                    onTabReminder
                        .frame(maxWidth: .infinity)
                        .offset(y:animate ? -5 : 5)
                        .animation(.linear(duration: 0.4).repeatForever(autoreverses: true), value: animate)
                        .onAppear {
                            animate = true
                        }
                }
               
                TMDBRatingView
                nameTag
                    .padding(.bottom)
                relatedCategories
                    .padding(.bottom)
                Text("Overview")
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .font(Font.custom("Montserrat-Bold", size: 20))
                    .padding(.bottom)
                movieOverView
                    .padding(.bottom)
                Text("Cast")
                    .fontWeight(.black)
                    .foregroundStyle(Color.white)
                    .font(Font.custom("Montserrat-Bold", size: 20))
                CastAndCrewView(movieCrewAndMovieCast: singleMovieViewModel.movieCastAndCrew)
                    .padding(.bottom)
            }.padding()
                .redacted(reason: singleMovieData == nil ? .placeholder : .privacy)
        }
    }
    private var mainImageView:some View{
        ZStack(alignment:.bottom){
            KFImage(URL(string: "\(String.posterBaseUrl(quality: "500"))\(singleMovieData?.posterPath ?? "")"))
                .resizable()
                .placeholder({ Progress in
                    Image("car")
                        .resizable()
                        .scaledToFit()
                })
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width,height: !viewExpand ? UIScreen.main.bounds.height * 0.58 : UIScreen.main.bounds.height * 0.38)
            LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
                .frame(height: 100)
        }
    }
    private var nameTag:some View{
        VStack(alignment:.leading){
            Text(singleMovieData?.title?.uppercased() ?? "place holder")
                .font(Font.custom("Montserrat-Bold", size: 25))
                .foregroundStyle(Color.white)
            Text(singleMovieData?.tagline?.uppercased() ?? "place holder")
                .font(Font.custom("Montserrat-Regular", size: 14))
                .foregroundStyle(LinearGradient(colors: [.green,.cyan], startPoint: .leading, endPoint: .trailing))
            Text(singleMovieData?.status ?? "")
                .font(Font.custom("Montserrat-Bold", size: 12))
                .foregroundStyle(Color.white)
                .padding(5)
                .background(Color.cyan)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.vertical,5)
                
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
                        .background(Color.blue.opacity(0.22))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }.scrollIndicators(.never)
            .scrollClipDisabled()
    }
    private var movieOverView:some View{
        VStack(alignment: .leading,spacing: 10){
            Text(singleMovieData?.overview ?? "place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder place holder ")
                .font(Font.custom("Montserrat-Regular", size: 14))
                .lineLimit(textExpand ? nil : 5)
                .foregroundStyle(Color.white)
            Button(action: {
                withAnimation {
                    textExpand.toggle()
                }
                
            }, label: {
                Text(!textExpand ? "See more" : "See less")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.mint)
            })
        }
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
    private var onTabReminder:some View{
        VStack(spacing:.zero){
            Image(systemName: "chevron.up")
                .resizable()
                .frame(width: 10,height: 5)
                .scaledToFit()
                .foregroundStyle(Color.white)
                
            Image(systemName: "chevron.up")
                .resizable()
                .frame(width: 10,height: 5)
                .scaledToFit()
                .foregroundStyle(Color.white)
            Text("Tab to exapand")
                .foregroundStyle(Color.white)
                .font(.system(size: 12))
                .padding(.vertical,5)
               
        }
    }
    private var favoirte:some View{
            
            VStack{
                Image(systemName:!isFavorite ? "heart" : "heart.fill")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundStyle(!isFavorite ? Color.white : Color.mint)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .background(Color.white.opacity(0.4))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        withAnimation {
                            isFavorite.toggle()
                            Task {
                                await singleMovieViewModel.setFavMoive(favMovieData:AddFavMovie(mediaType: "movie", mediaID: singleMovieData?.id ?? 0, favorite: true))
                            }
                        }
                       
                    }
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
    SingleMovieView(movieId: 533535, isMovie: false, networkManger: NetworkManager(), tmdbServiceLayer: TmdbDataDownloadServices(networkmanager: NetworkManager()))
}
