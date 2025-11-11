//
//  BreathViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import SwiftUI
internal import Combine

class BreathViewModel : ObservableObject {
    @Published var currentTheme = "Box" {
        didSet{
            let preset: BreathModel.Preset? = model.preset.first(where:{ $0.name == currentTheme })
            guard preset != nil else { return }
            
            model.currentPreset = preset!
            
            inhaleValue = preset!.inhaleValue
            inhaleHold = preset!.inhaleHold
            exhaleValue = preset!.exhaleValue
            exhaleHold = preset!.exhaleHold
        }
    }
    
    
    @Published var inhaleValue: Double = 4
    @Published var inhaleHold: Double = 1.5
    @Published var exhaleValue: Double = 4
    @Published var exhaleHold: Double = 1.5
    
    let model: BreathModel
    
    func applyCustomPreset(){
        model.update(BreathModel.Preset(name: "Custom", inhaleValue: inhaleValue, inhaleHold: inhaleHold, exhaleValue: exhaleValue, exhaleHold: exhaleHold))
    }
    
    func resetPreset(){
        
        inhaleValue = 1
        inhaleHold =  1
        exhaleValue = 1
        exhaleHold =  1
//        model.update(BreathModel.Preset(name: "Custom", inhaleValue: 1, inhaleHold: 1, exhaleValue: 1, exhaleHold: 1))
    }
    
    init(model: BreathModel){
        self.model = model
    }
}
