//
//  AppView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct AppView: View {
    @State var selectTab = "Home"
    @EnvironmentObject var breath: BreathModel
    @EnvironmentObject var presetStore: PresetStore
    let tabs = ["Home", "Presets", "Breath", "Settings"]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack(alignment: .bottom){
            TabView(selection: $selectTab){
                HomeView()
                    .tag("Home")
                PresetListView(presetStore)
                    .tag("Presets")
                BreathView(model: breath)
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
            .background(Color("MainBG").opacity(0.1))
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
                        Image(systemName: getImageName(tab))
                            .foregroundColor(selected == tab ?  .gray : .gray.opacity(0.5))
                            .frame(width: 20, height: 20)
                        
                    }
                }
            }
            .opacity(selected == tab ? 1 : 0.7)
            .padding(.vertical, 10)
            .padding(.horizontal, 17)
            .background(selected == tab ? .white.opacity(0.5) : Color("MainBG").opacity(0.5))
            .clipShape(Capsule())
        } else {
            ZStack{
                
                Button{
                    withAnimation(.spring()){
                        selected = tab
                    }
                }label: {
                    HStack{
                        Image(systemName: getImageName(tab))
                            .foregroundColor(selected == tab ?  .gray : .gray.opacity(0.5))
                            .frame(width: 20, height: 20)
                        
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
                .background(selected == tab ? .white.opacity(0.4) : Color("MainBG").opacity(0.2))
                .clipShape(Capsule())
            }
        }
    }

    private func getImageName(_ tab: String) -> String {
        switch tab {
        case "Home":
            "house.fill"
        case "Presets":
            "paintbrush.fill"
        case "Breath":
            "lungs.fill"
        case "Settings":
            "gearshape.fill"
        default:
            "exclamationmark.triangle.fill"
        }
    }
}

#Preview {
    let preset = PresetStore()
    AppView()
        .environmentObject(preset)
        .environmentObject(ThemeManager(store: preset))
        .environmentObject(BreathModel())
        .environmentObject(AppState())
        .environmentObject(SettingsManager())
}
