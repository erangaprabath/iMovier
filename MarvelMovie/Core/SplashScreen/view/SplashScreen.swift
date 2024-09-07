//
//  DashboardView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-08-31.
//

import SwiftUI

struct SplashScreen: View {
    @State private var nowData:Date = .now
    var posterUrl:String
    let text = "iMOVIER"
    @State private var displayedCharacters: Int = 0

    var body: some View {
        ZStack{
            Image("splashBackgroundImage")
                .resizable()
                .scaledToFill()
                .blendMode(.darken)
                .blur(radius: 3)
                .ignoresSafeArea()
            VStack{
                Spacer()
                TimelineView(.animation) { context in
                    let time = context.date.timeIntervalSince(nowData)
                    HStack(alignment: .center,spacing:-20){
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: time <= 0.1 ? 120 : 100,height: time <= 0.1 ? 120 : 100)
                            .offset(y: time <= 0.4 ? -100 : 0 )
                            .animation(.bouncy, value: time)
                        if time > 1{
                            Text(text.prefix(displayedCharacters))
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.mint,.white]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: .center))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .animation(.easeInOut, value: time)
                                .onAppear {
                                    let totalTime = 0.1
                                    let interval = totalTime / Double(text.count)
                                    
                                    Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                                        guard displayedCharacters < text.count else {
                                            timer.invalidate()
                                            return
                                        }
                                        displayedCharacters += 1
                                        
                                    }
                                }
                        }
                    }
                    
                }
                Spacer()
                HStack{
                    Text("Powered by")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        .font(Font.custom("Montserrat-Bold", size: 18))
                    Text("IMBD")
                        .textCase(.uppercase)
                        .foregroundStyle(LinearGradient(colors: [.red], startPoint: .leading, endPoint: .center))
                        .font(Font.custom("Montserrat-Bold", size: 18))
                    Text("ANd")
                        .textCase(.uppercase)
                        .foregroundStyle(.white)
                        .font(Font.custom("Montserrat-Bold", size: 18))
                     Text("SWIFT")
                        .textCase(.uppercase)
                        .foregroundStyle(Color.orange)
                        .font(Font.custom("Montserrat-Bold", size: 18))
                        .bold()
                 
                }
            }.padding(.horizontal)
         
        }
    }
}
extension SplashScreen{
    private var poterView:some View{
        HStack{
            AsyncImage(url: URL(string: posterUrl))
                .frame(width: 100,height: 100)
                .scaledToFit()
                
        }
    }
}

#Preview {
    SplashScreen(posterUrl: "https://prod-printler-front-as.azurewebsites.net/media/photo/131371.jpg?mode=crop&width=727&height=1024&rnd=0.0.1")
}
