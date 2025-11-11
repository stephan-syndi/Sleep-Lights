//
//  BreathViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import Foundation
import SwiftUI

@Observable class BreathViewModel {
    var currentTheme = "Box" {
        didSet{
            let preset: Preset? = model.preset.first(where:{ $0.name == currentTheme })
            guard preset != nil else { return }
            
            inhaleValue = preset!.inhaleValue
            inhaleHold = preset!.inhaleHold
            exhaleValue = preset!.exhaleValue
            exhaleHold = preset!.exhaleHold
        }
    }
    
    
    var inhaleValue: Float = 4
    var inhaleHold: Float = 1.5
    var exhaleValue: Float = 4
    var exhaleHold: Float = 1.5
    
    let model: BreathModel = BreathModel()
}
