//
//  SettingsView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @Environment(\.openURL) var openURL
    
    var body: some View {
        Form {
//            Section(header: Text("Gradient")) {
//                Picker("Default Kind", selection: Binding(
//                    get: { settingsManager.settings.gradientType },
//                    set: { new in settingsManager.update {current in
//                        var copy = current
//                        copy.gradientType = new
//                        return copy
//                    } }
//                )) {
//                    ForEach(GradientType.allCases, id: \.self) { type in
//                        Text(type.rawValue.capitalized).tag(type)
//                    }.pickerStyle(SegmentedPickerStyle())
//                }
//                
//                Picker("Animation Speed", selection: Binding(
//                    get: { settingsManager.settings.animationSpeed },
//                    set: { new in settingsManager.update { current in
//                        var copy = current
//                        copy.animationSpeed = new
//                        return copy
//                    } }
//                )) {
//                    ForEach(AnimationSpeed.allCases, id: \.self) { s in
//                        Text(s.rawValue.capitalized).tag(s)
//                    }
//                }
//            }
            
            Section(header: Text("Anti‑burnout")) {
                Picker("Amplitude of drift", selection: Binding(
                    get: { settingsManager.settings.driftAmplitude },
                    set: { new in settingsManager.update {current in
                        var copy = current
                        copy.driftAmplitude = new
                        return copy
                    } }
                )) {
                    ForEach(DriftAmplitude.allCases, id: \.self) { d in
                        Text(d.rawValue.capitalized).tag(d)
                    }
                }
            }
            
            Section(header: Text("Timer")) {
                Stepper(value: Binding(
                    get: { settingsManager.settings.defaultTimerSeconds },
                    set: { new in settingsManager.update {current in
                        var copy = current
                        copy.defaultTimerSeconds = new
                        return copy } }
                ), in: 0...3600, step: 15) {
                    Text("Default: \(settingsManager.settings.defaultTimerSeconds) sec")
                }
            }
            
            Section(header: Text("Theme")) {
                Picker("Interface Theme", selection: Binding(
                    get: { settingsManager.settings.theme },
                    set: { new in settingsManager.update{ current in
                        var copy = current
                        copy.theme = new
                        return copy } }
                )) {
                    ForEach(AppTheme.allCases, id: \.self) { t in
                        Text(displayName(for: t)).tag(t)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Notifications")) {
                Toggle(isOn: Binding(
                    get: { settingsManager.settings.notificationsEnabled },
                    set: {
                        new in settingsManager.update {current in
                            var copy = current
                            copy.notificationsEnabled = new
                            if new {
                                openNotificationSettings()
                            }
                            return copy
                        }
                        // если пользователь разрешил в UI — перенаправляем в системные настройки
                    }
                )) {
                    Text("Allow notifications")
                }
                
                Button("Open system notification settings") {
                    openNotificationSettings()
                }
            }
        }
        .navigationTitle("Settings")
    }
    
    private func displayName(for theme: AppTheme) -> String {
        switch theme {
        case .system: return "System"
        case .darkOnly: return "Dark-only"
        }
    }
    
    private func openNotificationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        openURL(url)
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsManager())
}
