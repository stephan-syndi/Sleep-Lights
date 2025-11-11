//
//  AppView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct AppView: View {
    @State var selectTab = "Home"
    
    let tabs = ["Home", "Presets", "Breath", "Settings"]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectTab){
                HomeView()
                    .tag("Home")
                NightlightView()
                    .tag("Presets")
                BreathView()
                    .tag("Breath")
                SettingsView()
                    .tag("Settings")
            }
            
            HStack{
                ForEach(tabs, id: \.self){ tab in
                    Spacer()
                    TabBarItem(tab: tab, selected: $selectTab)
                    Spacer()
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(Color("MainBG").opacity(0.5))
        }
    }
}

struct TabBarItem : View{
    @State var tab: String
    @Binding var selected: String
    var body: some View{
        if(tab == "Settings"){
            ZStack{
                
                Button{
                    withAnimation(.spring()){
                        selected = tab
                    }
                }label: {
                    HStack{
                        Image(tab)
                            .frame(width: 20, height: 20)
                            .colorInvert()
                        }
                    }
                }
                .opacity(selected == tab ? 1 : 0.7)
                .padding(.vertical, 10)
                .padding(.horizontal, 17)
                .background(selected == tab ? .white : Color("MainBG"))
                .clipShape(Capsule())
        } else {
            ZStack{
                
                Button{
                    withAnimation(.spring()){
                        selected = tab
                    }
                }label: {
                    HStack{
                        Image(tab)
                            .frame(width: 20, height: 20)
                            .colorInvert()
                        if(selected == tab){
                            Text(tab)
                                .font(.system(size: 14))
                                .foregroundStyle(.black)
                        }
                    }
                }
                .opacity(selected == tab ? 1 : 0.7)
                .padding(.vertical, 10)
                .padding(.horizontal, 17)
                .background(selected == tab ? .white : Color("MainBG"))
                .clipShape(Capsule())
            }
        }
    }}

#Preview {
    AppView()
}
