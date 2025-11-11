//
//  SettingsManager.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import Foundation
internal import Combine

protocol SettingsManaging: ObservableObject {
    var settings: AppSettings {get}
    var settingsPublisher: AnyPublisher<AppSettings, Never> {get}
    func update(_ transform: @escaping (AppSettings) -> AppSettings)
    func replace(_ new: AppSettings)
}

final class SettingsManager: SettingsManaging {
    @Published private(set) var settings: AppSettings
    
    var settingsPublisher: AnyPublisher<AppSettings, Never> {$settings.eraseToAnyPublisher()}
    
    private let storeKey = "app.settings.v1"
    private let queue = DispatchQueue(label: "com.mightteam.Sleep-Nights.settings.manager", qos: .userInitiated)
    private var cancellables = Set<AnyCancellable>()
    
    init(initial: AppSettings? = nil){
        if let data = UserDefaults.standard.data(forKey: storeKey),
           let decoded = try? JSONDecoder().decode(AppSettings.self, from: data){
            settings = decoded
        } else {
            settings = initial ?? AppSettings()
        }
        
        $settings
            .dropFirst()
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .sink { [weak self] new in
                            guard let self = self else { return }
                            self.queue.async {
                                if let data = try? JSONEncoder().encode(new) {
                                    UserDefaults.standard.set(data, forKey: self.storeKey)
                                }
                            }
                        }
            .store(in: &cancellables)
    }
    
    func update(_ transform: @escaping (AppSettings) -> AppSettings) {
            queue.async { [weak self] in
                guard let self = self else { return }
                let current = self.settings
                let update = transform(current)
                DispatchQueue.main.async {
                    self.settings = update
                }
            }
        }

        func replace(_ new: AppSettings) {
            queue.async { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.settings = new
                }
            }
        }
}
