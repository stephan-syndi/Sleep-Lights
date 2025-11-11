//
//  SettingsManager.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import Foundation
internal import Combine

protocol SettingsManager: ObservableObject {
    var settings: AppSettings {get}
    var settingsPublisher: AnyPublisher<AppSettings, Never> {get}
    func update(_ transform: (inout AppSettings) -> void)
    func replace(_ new: AppSettings)
}
