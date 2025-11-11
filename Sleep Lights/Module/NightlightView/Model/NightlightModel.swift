//
//  NightlightModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import Foundation
import SwiftUI

struct NightlightModel {
    let state: [String] = ["Fade In", "Fade out"]
    let circleSize: CGFloat = 220
    let minScale: CGFloat = 0.6
    let maxScale: CGFloat = 1.2
    
    var strategy: Strategy = Strategy(inhaleDuration: 0, inhaleHoldDuration: 0, exhaleDuration: 0, exhaleHoldDuration: 0)
    
    
    struct Strategy{
        var inhaleDuration: TimeInterval = 4.0
        var inhaleHoldDuration: TimeInterval = 1.5
        var exhaleDuration: TimeInterval = 4.0
        var exhaleHoldDuration: TimeInterval = 1.5
        
        init(inhaleDuration: TimeInterval, inhaleHoldDuration: TimeInterval, exhaleDuration: TimeInterval, exhaleHoldDuration: TimeInterval) {
            self.inhaleDuration = inhaleDuration
            self.inhaleHoldDuration = inhaleHoldDuration
            self.exhaleDuration = exhaleDuration
            self.exhaleHoldDuration = exhaleHoldDuration
        }
    }

   

    struct Timer {
        var remaining: TimeInterval = 0
        var lastRemaining: TimeInterval = 0
        var isRunning: Bool = false
        var interval: TimeInterval = 1.0
    }
    
    
}


