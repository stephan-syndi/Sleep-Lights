//
//  AngularAnimationView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct AngularAnimationView: View {
    
    var colors: [Color]
    
    var body: some View {
        TimelineView(.animation){ timeline in
                    let t = timeline.date.timeIntervalSinceReferenceDate
                    let offset = sin(t / 2) * 0.5 + 0.5
        
                    LinearGradient(
                               colors: colors,
                               startPoint: UnitPoint(x: offset, y: 0),
                               endPoint: UnitPoint(x: 1 - offset, y: 1))
                           .ignoresSafeArea()
                }
    }
}

#Preview {
    let colors: [Color] = [.red, .blue, .yellow]
    AngularAnimationView(colors: colors)
}
