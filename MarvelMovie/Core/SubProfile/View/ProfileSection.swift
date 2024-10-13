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
    var slideButton:Bool?
    @Binding var sideMenuOpen:Bool
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
                            .frame(width: slideButton ?? true ? 40 : 60,height:slideButton ?? true ? 40 : 60)
                    })
                    .resizable()
                    .scaledToFit()
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .frame(width: slideButton ?? true ? 40 : 60,height:slideButton ?? true ? 40 : 60)
                VStack(alignment:.leading){
                    Text("Hello, \(profileData?.name ?? "")")
                        .font(.custom("Montserrat-Regular", size: slideButton ?? true ? 12 : 20))
                        .foregroundStyle(Color.white)
                    if slideButton ?? true{
                        Text(profileData?.iso3166_1 ?? "")
                            .font(.custom("Montserrat-Regular", size: slideButton ?? true ? 12 : 20))
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
                if slideButton ?? true{
                    Image(systemName: "text.alignleft")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(Color.white)
                        .fontWeight(.black)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .onTapGesture {
                            withAnimation {
                                sideMenuOpen.toggle()
                            }
                        }
                }
              
            }
        }.onReceive(profileViewModel.$profile, perform: { newValue in
            profileData = newValue
        }).background(Color.clear)
    }
}

#Preview {
    ProfileSection(sideMenuOpen: .constant(true))
        .environmentObject(ProfileViewModel(dashboardViewModel: DashboardViewModel()))
}
