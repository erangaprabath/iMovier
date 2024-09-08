//
//  CastAndCrewView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-07.
//

import SwiftUI
import Kingfisher

struct CastAndCrewView: View {
    var movieCrewAndMovieCast:CastAndCrewModel?
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack{
                ForEach(movieCrewAndMovieCast?.cast ?? [],id: \.castID){ singleCastMember in
                    personDetailsView(profileUrl: singleCastMember.profilePath ?? "", personName: singleCastMember.name, role: singleCastMember.character ?? "")
                        .padding(.horizontal,5)
                }
                
            }
        }
       
    }
}
extension CastAndCrewView{
    private func personDetailsView(profileUrl:String,personName:String,role:String) -> some View{
        VStack(alignment: .center){
            KFImage(URL(string: "\(String.posterBaseUrl(quality: "500"))\(profileUrl)"))
                .placeholder({
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white,.mint)
                        .frame(width: 40,height: 40)
                })
                .resizable()
                .scaledToFill()
                .frame(width: 90,height: 110)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                
            Text(personName)
                .lineLimit(2, reservesSpace: true)
                .font(Font.custom("Montserrat-Bold", size: 10))
                .foregroundStyle(Color.white)
//            Text("Character : \(role.uppercased(with: .autoupdatingCurrent))")
//                .foregroundStyle(Color.white)
//                .font(Font.custom("Montserrat-Regular", size: 10))
//                .frame(width: 100)
//                .lineLimit(6)
//                .multilineTextAlignment(.leading)
            
        }
    }
}

#Preview {
    CastAndCrewView()
}
