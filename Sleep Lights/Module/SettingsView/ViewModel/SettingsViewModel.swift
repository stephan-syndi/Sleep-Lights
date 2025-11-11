//
//  SettingsViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import SwiftUI
internal import Combine

final class SettingsViewModel : ObservableObject{
    @Published private(set) var currentTheme: AppTheme = .system
    private var cancellables = Set<AnyCancellable>()
    private let manager: any SettingsManaging
    
    init(managing: any SettingsManaging) {
        self.manager = managing
        
        managing.settingsPublisher
            .map { $0.theme }
            .receive(on: DispatchQueue.main)
            .assign(to: \.currentTheme, on: self)
            .store(in: &cancellables)
    }
}
