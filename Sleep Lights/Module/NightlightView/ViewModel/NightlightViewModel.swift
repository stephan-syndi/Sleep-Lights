//
//  NightlightViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import Foundation
import SwiftUI

@Observable class NightlightViewModel {
    var model = NightlightModel()
    
    var scale: CGFloat = 0.6
    var label: String = "Ready"
    var currrentDuration: TimeInterval = 0
    
    private var runningTask: Task<Void, Never>? = nil
    var isRunning: Bool = false
    
    func onToggle(){
        isRunning ? onStop() : onStart()
    }
    
    func onStart(){
        guard runningTask == nil else {return}
        isRunning = true
        
        runningTask = Task {
            await self.breathLoop()
        }
    }
    
    func onStop(){
        runningTask?.cancel()
        runningTask = nil
        isRunning = false
    }
    
    func onSetDefault(){
        scale = model.minScale
        label = "Ready"
    }
    
    private func breathLoop() async {
        while !Task.isCancelled{
            await MainActor.run {
                self.label = model.state[0]
                self.scale = model.maxScale
                self.currrentDuration = model.strategy.inhaleDuration
            }
            try? await Task.sleep(nanoseconds: UInt64(model.strategy.inhaleDuration * 1_000_000_000))
            
            await MainActor.run { }
            try? await Task.sleep(nanoseconds: UInt64(model.strategy.inhaleHoldDuration * 1_000_000_000))
            
            await MainActor.run {
                self.label = model.state[1]
                self.scale = model.minScale
                self.currrentDuration = model.strategy.inhaleDuration
            }
            try? await Task.sleep(nanoseconds: UInt64(model.strategy.exhaleDuration * 1_000_000_000))
            
            await MainActor.run { }
            try? await Task.sleep(nanoseconds: UInt64(model.strategy.exhaleHoldDuration * 1_000_000_000))
        }
        
        await MainActor.run{
            self.label = "Ready"
            self.isRunning = false
        }
    }
}
