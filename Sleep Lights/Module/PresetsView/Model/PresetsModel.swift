//
//  PresetsModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
internal import Combine

extension PresetsView {
    @Observable
    class PresetsModel {
        var presets: [String] = ["Focus 5m", "Relax 10m", "Deep 20m"]
        
        func addPreset(_ name: String){
            presets.append(name)
        }
        
        func remove(at offset: IndexSet){
            presets.remove(atOffsets: offset)
        }
    }
}
