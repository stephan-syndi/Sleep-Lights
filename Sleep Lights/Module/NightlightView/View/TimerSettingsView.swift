//
//  TimerSettingsView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 31.10.25.
//

import SwiftUI

struct TimerSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State var selectedTime = Date()
    
    var body: some View {
        ZStack{
            NightlightAnimationView()
            
            
            VStack{
                Text("Timer Settings")
                    .font(.title)
                
                DatePicker(
                    "Time",
                    selection: $selectedTime,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
            }
        }
    }
}

#Preview {
    TimerSettingsView()
}
