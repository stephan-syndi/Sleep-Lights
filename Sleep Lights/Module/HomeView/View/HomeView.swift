//
//  HomeView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 16){
            Text("Welcome Home")
                .font(.largeTitle)
            VStack{
                Button("Start Nightlight"){
                    
                }
                .buttonStyle(.borderedProminent)
                
                
                
                 Button("Timer"){
                    
                }
                .buttonStyle(.borderedProminent)
                
                 Button("Choose Theme"){
                    
                }
                .buttonStyle(.borderedProminent)
                 Button("Quick Presets"){
                    
                }
                .buttonStyle(.borderedProminent)
                
                Button("Last Presets"){
                    
                }
                .buttonStyle(.borderedProminent)
            
            }
            
        }
    }
}

#Preview {
    HomeView()
}
