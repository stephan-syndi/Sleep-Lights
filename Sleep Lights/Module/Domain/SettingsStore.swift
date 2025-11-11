//
//  SettingsStore.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import Foundation
internal import Combine

protocol SettingsStore {
    var settingsPublisher: AnyPublisher<AppSettings, Never> { get }
    func save(_ settings: AppSettings)
    func load() -> AppSettings
}

final class UserDefaultsSettingsStore: ObservableObject, SettingsStore {
    private let key = "app.settings.v1"
    private let subject: CurrentValueSubject<AppSettings, Never>
    var settingsPublisher: AnyPublisher<AppSettings, Never> { subject.eraseToAnyPublisher() }

    init(initial: AppSettings? = nil) {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode(AppSettings.self, from: data) {
            subject = CurrentValueSubject(decoded)
        } else {
            subject = CurrentValueSubject(initial ?? AppSettings())
        }
    }

    func save(_ settings: AppSettings) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: key)
        }
        subject.send(settings)
    }

    func load() -> AppSettings {
        subject.value
    }
}

