//
//  HudNightlightView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 31.10.25.
//

import SwiftUI

struct HudNightlightView: View {
    
    @Binding var showTimerSettings: Bool
    
    var body: some View {
        
        Button()
        {
            showTimerSettings = true
        }label: {
            Text("Timer: 01:20")
                .font(.largeTitle)
                .foregroundStyle(.white.opacity(0.5))
        }
    }
}
