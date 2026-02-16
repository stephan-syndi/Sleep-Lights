//
//  InternetAlertView.swift
//  MixFruits
//
//  Created by Stepan Degtsiaryk on 29.01.26.
//

import SwiftUI

struct InternetAlertView: View {
    var body: some View {
        ZStack{
            VStack{
//                Image(ImageResource.warning)
                    
                ZStack{
                    Image(ImageResource.popup)
                        .resizable(
                        )
                        .frame(width: 340, height: 300)
                    Text("Please, check your internet connection and restart")
                        .foregroundColor(.white)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom, 20)
                        .frame(width: 220, height: 200)
                        .lineLimit(3)
                        .minimumScaleFactor(0.5)
              }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .background{
            GeometryReader{ geo in
                Image(ImageResource.back)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    InternetAlertView()
}
