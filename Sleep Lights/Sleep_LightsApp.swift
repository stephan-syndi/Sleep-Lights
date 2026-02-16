//
//  Sleep_LightsApp.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 28.10.25.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import DarkCoreFramework

@main
struct Sleep_LightsApp: App {
    @UIApplicationDelegateAdaptor(DarkAppDelegate.self) var appDelegate
    let config = Configuration(
        appsDevKey: "o8PDRbGWLDVLzfPTZ7Zzfa",
        appleAppId: "6758833042",
        endpoint: "https://sleepliights.com",
        firebaseGCMSenderId: "461322382222"
    )

    private let router: AppRouter
    
    @StateObject private var appState = AppState()
    @StateObject private var manager = SettingsManager()
    @StateObject private var presetStore = PresetStore()
    
    init() {
        router = DarkCore.configure(config: config, clearView: ContentView())

        router.setScreen(screen: .clear, view: ContentView())
        router.setScreen(screen: .curtain, view: CurtainView())
        router.setScreen(screen: .permission, view: PermissionView(viewModel: router.getPermissionViewModel()))
        router.setScreen(screen: .internet, view: InternetAlertView())
        
        appDelegate.router = router
    }
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environmentObject(router)
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
