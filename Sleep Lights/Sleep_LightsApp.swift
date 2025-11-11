//
//  Sleep_LightsApp.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 28.10.25.
//

import SwiftUI

@main
struct Sleep_LightsApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var manager = SettingsManager()
    @StateObject private var presetStore = PresetStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(manager)
                .environmentObject(BreathModel())
                .environmentObject(presetStore)
                .environmentObject(ThemeManager(store: presetStore))
        }
    }
}
