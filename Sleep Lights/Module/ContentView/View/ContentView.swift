//
//  ContentView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 28.10.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var breath: BreathModel
    
    var body: some View {
        switch appState.root {
        case .main:
            AppView()
                .preferredColorScheme(settingsManager.settings.theme == .darkOnly ? .dark : nil)
        case .nightlight:
            NightlightView(breath: breath)
        }
    }
}

#Preview {
    ContentView()
}
