//
//  TimeIntervalPicker.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import SwiftUI

struct TimeIntervalPicker: View {
    @Binding var totalSeconds: TimeInterval
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 0
    @State private var seconds: Int = 0
    
    private let hoursRange = Array(0...23)
    private let minutesRange = Array(0...59)
    private let secondsRange = Array(0...59)
    
    var body: some View {
        HStack(spacing: 8) {
            // Часы
            Picker(selection: $hours, label: Text("Hours")) {
                ForEach(hoursRange, id: \.self) { h in
                    Text(String(format: "%02d", h)).tag(h)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: 80)
            .clipped()
            
            // Минуты
            Picker(selection: $minutes, label: Text("Minutes")) {
                ForEach(minutesRange, id: \.self) { m in
                    Text(String(format: "%02d", m)).tag(m)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: 80)
            .clipped()
            
            // Секунды
            Picker(selection: $seconds, label: Text("Seconds")) {
                ForEach(secondsRange, id: \.self) { s in
                    Text(String(format: "%02d", s)).tag(s)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(maxWidth: 80)
            .clipped()
        }
        .onChange(of: hours) { _ in updateTotal() }
        .onChange(of: minutes) { _ in updateTotal() }
        .onChange(of: seconds) { _ in updateTotal() }
        .onAppear { // если нужно инициализировать из totalSeconds
            setFromTotal()
        }
    }
    
    private func updateTotal() {
        totalSeconds = TimeInterval(hours * 3600 + minutes * 60 + seconds)
    }
    
    private func setFromTotal() {
        let total = Int(totalSeconds)
        hours = (total / 3600) % 24
        minutes = (total % 3600) / 60
        seconds = total % 60
    }
}

//#Preview {
//    TimeIntervalPicker()
//}
