//
//  SettingsView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("theme") private var theme = "System"
    
    var body: some View {
        Form{
            Section(header: Text("General")){
                Toggle("Sound", isOn: $soundEnabled)
                Picker("Theme", selection: $theme){
                    Text("System")
                        .tag("System")
                    Text("Light")
                        .tag("Light")
                    Text("Dark")
                        .tag("Dark")
                }
            }
            
            Section{
                Button("Reset Data"){
                    
                }
                .foregroundColor(.red)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView()
}
