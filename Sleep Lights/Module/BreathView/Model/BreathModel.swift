//
//  BreathModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import Foundation
internal import Combine

final class BreathModel : ObservableObject {
    @Published var currentPreset: Preset
    
    let theme: [String] = ["Box", "4-7-8", "Coherent", "Custom"]
    
    var preset: [Preset] =
    [
        Preset(name: "Box", inhaleValue: 4, inhaleHold: 1.5, exhaleValue: 4, exhaleHold: 1.5),
        Preset(name: "4-7-8", inhaleValue: 4, inhaleHold: 7, exhaleValue: 8, exhaleHold: 0.5),
        Preset(name: "Coherent", inhaleValue: 5, inhaleHold: 0.1, exhaleValue: 5, exhaleHold: 0.1),
        Preset(name: "Custom", inhaleValue: 1, inhaleHold: 1, exhaleValue: 1, exhaleHold: 1)
    ]
    
    init(){
        self.currentPreset = preset.first(where: {$0.name == "Box"}) ??  Preset(name: "Box", inhaleValue: 4, inhaleHold: 1.5, exhaleValue: 4, exhaleHold: 1.5)
    }
    
    func update(_ transform: Preset){
        preset[3] = transform
    }
    
    func getStrategy() -> NightlightModel.Strategy? {
        
        let strategy = NightlightModel.Strategy(inhaleDuration: currentPreset.inhaleValue,
                                         inhaleHoldDuration: currentPreset.inhaleHold,
                                         exhaleDuration: currentPreset.exhaleValue,
                                         exhaleHoldDuration: currentPreset.exhaleHold)
        
        return strategy
    }
    
    struct Preset {
        let name: String
        
        var inhaleValue: Double
        var inhaleHold: Double
        var exhaleValue: Double
        var exhaleHold: Double
    }
}


