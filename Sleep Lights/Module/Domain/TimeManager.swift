//
//  TimeManager.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 5.11.25.
//

import Foundation
internal import Combine

final class TimeManager : ObservableObject {
    @Published private(set) var model: NightlightModel.Timer
    
    let finished = PassthroughSubject<Void, Never>()
    
    private var timer: DispatchSourceTimer?
    private let queue = DispatchQueue(label: "com.nightteam.Sleep-Lights")
    private var cancellabled = Set<AnyCancellable>()
    private var lastFireDate: Date?
    
    
    init(initial: NightlightModel.Timer = NightlightModel.Timer()) {
        self.model = initial
    }
    
    func start() {
        queue.async { [weak self] in
            guard let self = self, !self.model.isRunning, self.model.remaining > 0 else { return }
            self.model.isRunning = true
            self.lastFireDate = Date()
            self.setupTimerLocked()
            self.publishModelOnMain()
        }
    }
    
    func stop() {
        queue.async { [weak self] in
            guard let self = self, self.model.isRunning else { return }
            self.model.isRunning = false
            self.invalidateTimerLocked()
            self.publishModelOnMain()
        }
    }
    
    func reset(){
        queue.async { [weak self] in
            guard let self = self else { return }
            self.model.remaining = max(0, self.model.lastRemaining)
            self.invalidateTimerLocked()
            self.model.isRunning = false
            self.publishModelOnMain()
        }
    }
    
    func reset(to seconds: TimeInterval) {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.model.remaining = max(0, seconds)
            self.model.isRunning = false
            self.invalidateTimerLocked()
            self.publishModelOnMain()
        }
    }
    
    func setRemaining(_ seconds: TimeInterval) {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.model.remaining = max(0, seconds)
            self.model.lastRemaining = max(0, seconds)
            // если оставшегося времени 0 и таймер был запущен — остановим и эмитим finished
            if self.model.remaining <= 0 {
                self.model.isRunning = false
                self.invalidateTimerLocked()
                self.publishModelOnMain()
                self.emitFinishedOnMain()
            } else {
                self.publishModelOnMain()
            }
        }
    }
    
    func setInterval(_ interval: TimeInterval) {
        queue.async { [weak self] in
            guard let self = self else { return }
            let newInterval = max(0.01, interval)
            self.model.interval = newInterval
            // если запущено — пересоздать таймер с новым интервалом
            if self.model.isRunning {
                self.invalidateTimerLocked()
                self.setupTimerLocked()
            }
            self.publishModelOnMain()
        }
    }
    
    func setRunning(_ running: Bool) {
        print("TimeInterval: \(self.model.remaining) секунд")
        running ? start() : stop()
    }
    
    // MARK: - Internal timer handling (вызовы внутри queue)
    
    private func setupTimerLocked() {
        guard timer == nil else { return }
        let t = DispatchSource.makeTimerSource(queue: queue)
        let interval = model.interval
        // schedule: более точный вариант — fire every small tick and compute delta via Date
        t.schedule(deadline: .now() + interval, repeating: interval, leeway: .milliseconds(10))
        t.setEventHandler { [weak self] in
            self?.timerFiredLocked()
        }
        t.resume()
        timer = t
    }
    
    private func invalidateTimerLocked() {
        if let t = timer {
            t.setEventHandler(handler: nil)
            t.cancel()
            timer = nil
            lastFireDate = nil
        }
    }
    
    private func timerFiredLocked() {
        // вычислять реальное прошедшее время по датам, чтобы уменьшить дрейф
        let now = Date()
        let delta: TimeInterval
        if let last = lastFireDate {
            delta = now.timeIntervalSince(last)
        } else {
            delta = model.interval
        }
        lastFireDate = now
        
        model.remaining -= delta
        if model.remaining <= 0 {
            model.remaining = 0
            model.isRunning = false
            invalidateTimerLocked()
            // сначала публикуем модель, затем эмитим finished на main
            publishModelOnMain()
            emitFinishedOnMain()
            return
        }
        publishModelOnMain()
    }
    
    // MARK: - Публикация на main
    
    private func publishModelOnMain() {
        let snapshot = self.model
        DispatchQueue.main.async { [weak self] in
            self?.model = snapshot
        }
    }
    
    private func emitFinishedOnMain() {
        DispatchQueue.main.async { [weak self] in
            self?.finished.send(())
        }
    }
    
    deinit {
        queue.sync {
            invalidateTimerLocked()
        }
    }
}

extension TimeManager {
    static let shared = TimeManager(initial: NightlightModel.Timer(lastRemaining: 0, isRunning: false, interval: 1.0))
}
