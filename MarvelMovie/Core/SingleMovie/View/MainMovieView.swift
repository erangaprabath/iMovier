//
//  MainMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-05.
//

import SwiftUI
import Kingfisher

struct MainMovieView: View {
    var body: some View {
        VStack(spacing:.zero){
            ZStack(alignment:.bottom){
                mainImageView
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    .ignoresSafeArea()
                LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
                    
            }
            
            ZStack {
                
                Rectangle()
                    .ignoresSafeArea()
                .frame(height: UIScreen.main.bounds.height * 0.5)
                nameTag
            }
                
        }
    }
}
extension MainMovieView{
    private var mainImageView:some View{
        VStack{
            KFImage(URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/8971ab4e-777c-4897-b797-ddc3448e6bda/dd3psy0-338e175b-e77f-4704-aade-a79b7a73d1c1.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzg5NzFhYjRlLTc3N2MtNDg5Ny1iNzk3LWRkYzM0NDhlNmJkYVwvZGQzcHN5MC0zMzhlMTc1Yi1lNzdmLTQ3MDQtYWFkZS1hNzliN2E3M2QxYzEuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.qxV1ADFm_Hr6BpCJFsc9SW0e4OliE-vckP_YLJ9Wgvk"))
                .resizable()
                .scaledToFill()
        }
    }
    private var nameTag:some View{
        VStack{
            Text("Joker")
                .font(.title)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    MainMovieView()
}
