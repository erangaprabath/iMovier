//
//  SingelePopularMovieView.swift
//  MarvelMovie
//
//  Created by Eranga prabath on 2024-09-06.
//

import SwiftUI
import Kingfisher

struct SingelePopularMovieView: View {
    @StateObject private var popMovieViewModel:
    var body: some View {
        VStack{
            moviePosterView
        }
    }
}
extension SingelePopularMovieView{
    private var moviePosterView:some View{
        KFImage(URL(string: ""))
    }
}

#Preview {
    SingelePopularMovieView()
}
