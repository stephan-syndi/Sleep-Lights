//
//  CurtainView.swift
//  MixFruits
//
//  Created by Stepan Degtsiaryk on 29.01.26.
//

import SwiftUI

struct CurtainView: View {
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                Image(ImageResource.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                Image(ImageResource.loader)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160)
                Spacer()
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
                    .padding()
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
    CurtainView()
}
