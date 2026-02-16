//
//  Sleep_LightsApp.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 28.10.25.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

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
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { requestTrackingPermission() }
                }
        }
    }
    
    private func requestTrackingPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
            }
        }
    }
}
