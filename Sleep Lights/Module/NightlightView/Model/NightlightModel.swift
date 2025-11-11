//
//  NightlightModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import Foundation
import SwiftUI

class NightlightModel {
    
    
    let state: [String] = ["Fade In", "Fade out"]
    let circleSize: CGFloat = 220
    let minScale: CGFloat = 0.6
    let maxScale: CGFloat = 1.2
    
    
    var strategy: Strategy = Strategy()
    
}

struct Strategy{
    var inhaleDuration: TimeInterval = 4.0
    var inhaleHoldDuration: TimeInterval = 1.5
    var exhaleDuration: TimeInterval = 4.0
    var exhaleHoldDuration: TimeInterval = 1.5
}

struct AnimationPreset {
    var gradient: AnimationGradien
    var colors: [Color]
}

enum AnimationGradien {
    case liner, radial, angular
}

