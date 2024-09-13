//
//  ProfileSection.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-01.
//

import SwiftUI
import Kingfisher

struct ProfileSection: View {
    @EnvironmentObject private var profileViewModel:ProfileViewModel
    @State private var profileData:ProfileModel? = nil
    var body: some View {
        VStack{
            HStack(spacing:10){
                KFImage(URL(string: "https://image.tmdb.org/t/p/w185\(profileData?.avatar.tmdb.avatarPath ?? "")"))
                    .placeholder({ Progress in
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.white,.mint)
                            .frame(width: 40,height: 40)
                    })
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: 40,height: 40)
                VStack(alignment:.leading){
                    Text("Hello, \(profileData?.name ?? "")")
                        .font(.custom("Montserrat-Regular", size: 12))
                        
                        .foregroundStyle(Color.white)
                       
                    Text(profileData?.iso3166_1 ?? "")
                        .font(.custom("Montserrat-Regular", size: 12))
                        .foregroundStyle(Color.white)
                }
                Spacer()
                Image(systemName: "text.alignleft")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20,height: 20)
                    .foregroundStyle(Color.white)
                    .fontWeight(.black)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
              
            }
        }.onReceive(profileViewModel.$profile, perform: { newValue in
            profileData = newValue
        }).background(Color.clear)
    }
}

#Preview {
    ProfileSection()
}
