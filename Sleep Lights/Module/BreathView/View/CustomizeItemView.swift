//
//  CustomizeItemView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import SwiftUI

struct CustomizeItemView: View {
    @Binding var value: Float
    
    var body: some View {
        Slider(value: $value, in: 0...10, step: 1){
            Text("Inhale")
        }
        minimumValueLabel: {
            Text("0")
        }
        maximumValueLabel: {
                Text("10")
            }
    }
}
