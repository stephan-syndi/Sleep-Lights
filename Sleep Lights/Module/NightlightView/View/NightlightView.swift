//
//  NightlightView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct NightlightView: View {
    
    @State private var vm: NightlightViewModel = NightlightViewModel()
    
    @State private var brightness: Double = 0.0
    @State private var lastDragValue: CGFloat = 0
    
    @State private var showTimerSettings = false
    @State private var showHud = true
    
    var body: some View {
        ZStack{
            NightlightAnimationView()
            VStack{
                
                if showHud {
                    HudNightlightView(showTimerSettings: $showTimerSettings)
                    Spacer()
                }
                
                BreathElementView(vm: $vm)
                    
                if showHud {
                    Spacer()
                }
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
            TimerSettingsView()
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
    }
}

#Preview {
    NightlightView()
}
