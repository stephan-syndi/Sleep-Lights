//
//  NightlightView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct NightlightView: View {
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject private var settingsManager: SettingsManager
    @StateObject private var vm: NightlightViewModel
    
    @State private var brightness: Double = 0.0
    @State private var lastDragValue: CGFloat = 0
    
    @State private var showTimerSettings = false
    @State private var showHud = true
    
    init(manager: TimeManager = .shared, breath: BreathModel){
        _vm = StateObject(wrappedValue: NightlightViewModel(manager: manager, breath: breath))
    }
    
    var body: some View {
        ZStack{
            theme.backgroundGradient
                .ignoresSafeArea()
            
            HudNightlightView(showTimerSettings: $showTimerSettings, vm: vm)
                .visibility(showHud ? .visible : .invisible)
            
            VStack{
                BreathElementView(vm: vm)
            }
        }
        .gesture(
            DragGesture()
                .onChanged {value in
                    let delta = value.translation.height - lastDragValue
                    lastDragValue = value.translation.height
                    
                    brightness -= delta / 500
                    brightness = min(max(brightness, -0.5), 0)
                }
                .onEnded {_ in
                    lastDragValue = 0
                }
        )
        .brightness(brightness)
        .sheet(isPresented: $showTimerSettings){
            TimerSettingsView(duration: TimeInterval(settingsManager.settings.defaultTimerSeconds))
                .onAppear{
                    print("def \(settingsManager.settings.defaultTimerSeconds)")
                }
        }
        .onAppear{
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear(){
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onLongPressGesture(minimumDuration: 1.0){
            showHud.toggle()
        }
        .onTapGesture(count: 2){
            vm.onToggle()
        }
    }
}

#Preview {
    NightlightView(breath: BreathModel())
        .environmentObject(ThemeManager(store: PresetStore()))
        .environmentObject(SettingsManager())
        .environmentObject(PresetStore())
}
