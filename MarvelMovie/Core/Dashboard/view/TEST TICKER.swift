//
//  TEST TICKER.swift
//  MarvelMovie
//
//  Created by Eranga Prabath on 2024-10-01.
//

import SwiftUI

struct TEST_TICKER: View {
    @State private var warningToggle:Bool = false
    var body: some View {
        
        VStack(spacing:.zero) {
            if warningToggle{
                view
                    .transition(.scale)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                            withAnimation {
                                warningToggle = false
                            }
                           
                        }
                    }
            }
            Button {
                withAnimation(.bouncy) {
                    warningToggle.toggle()
                    
                }
            } label: {
                Text("Button")
            }
        }.frame(maxWidth: .infinity)
            .frame(height: 100)
        .background(Color.red)

    }
}
extension TEST_TICKER{
    private var view:some View{
        VStack{
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 50)
        }
    }
}

#Preview {
    TEST_TICKER()
}
