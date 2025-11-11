//
//  HomeView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject private var settingsManager: SettingsManager
    @State private var isShowPopup: Bool = false
    
    @State var showTimerSettings: Bool = false
    @State var showPopup = false
    @State var isActive = false
    
    var body: some View {
        ZStack{
            //            NightlightAnimationView()
            themeManager.backgroundGradient.ignoresSafeArea()
            VStack{
                Image(.logo)
                    .resizable()
                    .frame(width: 200, height: 200)
                    .listRowBackground(Color.clear)
                Spacer()
                
                HStack(alignment: .center, spacing: 16){
                    VStack{
                        Button()
                        {
                            withAnimation{
                                appState.root = .nightlight
                            }
                        } label: {
                            Image(systemName: "play.fill")
                                .font(.title)
                                .imageScale(.large)
                                .padding(.horizontal, 12)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Capsule()
                        )
                        
                    }
                    
                }
                .listRowBackground(Color.clear)
                
                HStack(alignment: .center, spacing: 16){
                    Button()
                    {
                        isShowPopup = true
                    }label: {
                        Image(systemName: "hourglass")
                            .foregroundColor(.white)
                            .font(.title)
                            .imageScale(.large)
                    }
                    .padding()
                    .foregroundColor(.black)
                    .fixedSize(horizontal: true, vertical: true)
                    .background(Color.green.opacity(0.5))
                    .clipShape(Circle())

                }
                .listRowBackground(Color.clear)
                
                
                Spacer()
                
            }
            .padding()
            .sheet(isPresented: $isShowPopup){
                TimerSettingsView(duration: TimeInterval(settingsManager.settings.defaultTimerSeconds))
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(ThemeManager(store: PresetStore()))
        .environmentObject(AppState())
        .environmentObject(SettingsManager())
}
