//
//  BackButtonView.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-09-06.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
           Image(systemName:"arrow.left")
                .resizable()
                .scaledToFit()
                .frame(width: 20,height: 20)
                .foregroundStyle(Color.white)
                .padding(10)
                .background(Color.gray.opacity(0.5))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        })
    }
}

#Preview {
    BackButtonView()
}
