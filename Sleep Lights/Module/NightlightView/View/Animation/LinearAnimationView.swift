//
//  LinearAnimationView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct LinearAnimationView: View {
    var colors: [Color]
    
    @State private var animate = false
    
    @State private var start = UnitPoint.topLeading
    @State private var end = UnitPoint.bottomTrailing
    @State private var isOn = false
    
    var body: some View {
        
        LinearGradient(
            colors: isOn ? colors : colors.reversed(),
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isOn)
        .onAppear {
            isOn.toggle()
        }
    }
}

#Preview {
    let colors: [Color] = [.red, .blue, .yellow]
    LinearAnimationView(colors: colors)
}
