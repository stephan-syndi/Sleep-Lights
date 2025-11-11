//
//  RadialAnimationView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct RadialAnimationView: View {
    var colors: [Color]
    
    var body: some View {
        TimelineView(.animation) { timeline in
                    let t = timeline.date.timeIntervalSinceReferenceDate
                    
                    // параметры траектории
                    let A = 0.1   // амплитуда по X
                    let B = 0.1   // амплитуда по Y
                    let a = 3.0   // частота по X
                    let b = 2.0   // частота по Y
                    let δ = Double.pi / 2 // фазовый сдвиг
                    
                    // вычисляем координаты
                    let x = 0.5 + A * sin(a * t + δ)
                    let y = 0.5 + B * sin(b * t)
                    
                    RadialGradient(
                        gradient: Gradient(colors: colors),
                        center: UnitPoint(x: x, y: y),
                        startRadius: 50,
                        endRadius: 500
                    )
                    .ignoresSafeArea()
                }
    }
}

#Preview {
    let colors: [Color] = [.red, .blue, .yellow]
    RadialAnimationView(colors: colors)
}
