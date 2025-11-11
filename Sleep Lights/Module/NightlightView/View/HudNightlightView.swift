//
//  HudNightlightView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 31.10.25.
//

import SwiftUI

struct HudNightlightView: View {
    @EnvironmentObject var appState: AppState
    @Binding var showTimerSettings: Bool
    @StateObject var vm: NightlightViewModel
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                VStack{
                    HStack(alignment: .center){
                        Button{
                            withAnimation{
                                appState.root = .main
                            }
                        }label: {
                            Image(.home)
                        }
                        .buttonStyle(.bordered)
                        
                        Spacer()
                    }
                    .padding()
                    Button()
                    {
                        showTimerSettings = true
                    }label: {
                        Text(vm.remainingText)
                            .font(.largeTitle)
                            .foregroundStyle(.white.opacity(0.5))
                    }
                    .buttonStyle(.bordered)
                    
                    .padding()
                    Spacer()
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}
