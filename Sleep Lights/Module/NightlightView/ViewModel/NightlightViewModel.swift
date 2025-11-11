//
//  NightlightViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
internal import Combine


class NightlightViewModel: ObservableObject {
    
    @Published var model = NightlightModel()
    private var breath: BreathModel
    
    @Published var scale: CGFloat = 0.6
    @Published var label: String = "Ready"
    @Published var currrentDuration: TimeInterval = 0
    @Published var isRunning: Bool = false
    
    // Timer
    @Published var isTimerRunning: Bool = false
    @Published var remainingText: String = "00:00:00"
    
    private var runningTask: Task<Void, Never>? = nil
    private let manager: TimeManager
    private var cancellables = Set<AnyCancellable>()
    
    init(manager: TimeManager = .shared, breath: BreathModel){
        self.manager = manager
        self.breath = breath
        
        manager.$model
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] model in
                guard let self = self else {return}
                self.isTimerRunning = model.isRunning
                self.remainingText = Self.formatTime(model.remaining)
            }
            .store(in: &cancellables)
        
        manager.finished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                // можно показать уведомление, проиграть звук и т.п.
                self?.handleFinished()
            }
            .store(in: &cancellables)
        
        
    }
    
    func onToggle(){
        isRunning ? onStop() : onStart()
        manager.setRunning(!isTimerRunning)
    }
    
    func onStart(){
        guard runningTask == nil else {return}
        setPresetStrategy()
        
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
    
    func setRemaining(_ seconds: TimeInterval) {
        manager.setRemaining(seconds)
    }
    
    func resetTapped(to seconds: TimeInterval) {
        manager.reset(to: seconds)
    }
    
    func onSetDefault(){
        scale = model.minScale
        label = "Ready"
        manager.reset()
    }
    
    
    func changeInterval(to interval: TimeInterval){
        manager.setInterval(interval)
    }
    
    private func setPresetStrategy(){
        let strategy = breath.getStrategy()
        guard strategy != nil else {return}
        
        model.strategy = strategy!
    }
    
    private func handleFinished() {
        onStop()
        // реакция на окончание таймера
        // например, обновить UI, проиграть звук и т.д.
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
    
    private static func formatTime(_ t: TimeInterval) -> String {
        let total = max(0, Int(ceil(t))) // округлим вверх чтобы показать 00:01 когда 0.2s осталось
        let seconds = total % 60
        let minutes = (total / 60) % 60
        let hours = (total / 3600) % 24
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
