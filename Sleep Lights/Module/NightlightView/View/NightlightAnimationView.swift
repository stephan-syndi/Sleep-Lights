//
//  NightlightAnimationView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import SwiftUI

struct NightlightAnimationView: View {
    @State private var animate = false
    
    @State private var start = UnitPoint.topLeading
    @State private var end = UnitPoint.bottomTrailing
    
    @State private var isOn = false
    
    var body: some View {
               
       // Angular
//        TimelineView(.animation){ timeline in
//            let t = timeline.date.timeIntervalSinceReferenceDate
//            let offset = sin(t / 2) * 0.5 + 0.5
//        
//            LinearGradient(
//                       colors: [Color("SunsetFirst"), Color("SunsetSecond"), Color("SunsetThird")],
//                       startPoint: UnitPoint(x: offset, y: 0),
//                       endPoint: UnitPoint(x: 1 - offset, y: 1))
//                   .ignoresSafeArea()
//        }
        
//        TimelineView(.animation) { timeline in
//                    let t = timeline.date.timeIntervalSinceReferenceDate
//                    let angle = sin(t) * 180 // колебания от -180° до 180°
//                    
//                    LinearGradient(
//                        colors: [Color("SunsetFirst"), Color("SunsetSecond"), Color("SunsetThird")],
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                    .hueRotation(.degrees(angle))
//                    .ignoresSafeArea()
//                }
        
        // Radial Lissajous
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
                        gradient: Gradient(colors: [Color("SunsetSecond"), Color("SunsetThird"), Color("SunsetFirst")]),
                        center: UnitPoint(x: x, y: y),
                        startRadius: 50,
                        endRadius: 500
                    )
                    .ignoresSafeArea()
                }
        
 // Array color animation
//        LinearGradient(
//            colors: isOn ? [.orange, .pink] : [.blue, .purple],
//            startPoint: .top,
//            endPoint: .bottom)
//        .ignoresSafeArea()
//        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isOn)
//        .onAppear {
//            isOn.toggle()
//        }
    }
}

#Preview {
    NightlightAnimationView()
}
