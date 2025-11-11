//
//  TimerSettingsView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 31.10.25.
//

import SwiftUI

struct TimerSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var themeManager: ThemeManager
   
    
    @State private var duration: TimeInterval
    
    private let manager: TimeManager
    
    init(manager: TimeManager = .shared, duration: TimeInterval = 60){
        self.manager = manager
        self.duration = duration
    }
    
    var body: some View {
        ZStack{
            themeManager.backgroundGradient.ignoresSafeArea()
            
            VStack{
                Text("Timer")
                    .font(.title)
                
            
                TimeIntervalPicker(totalSeconds: $duration)
                    
                HStack(spacing: 26){
                    Button{
                        manager.setRemaining(duration)
                        dismiss()
                        
                    }label: {
                        Text("Set")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button{
                        duration = manager.model.lastRemaining
                    }label: {
                        Text("Reset")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    TimerSettingsView()
        .environmentObject(ThemeManager(store: PresetStore()))
        .environmentObject(SettingsManager())
}
