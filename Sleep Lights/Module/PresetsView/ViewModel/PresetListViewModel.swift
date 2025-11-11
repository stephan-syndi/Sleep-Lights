//
//  PresetListViewModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI
internal import Combine

final class PresetListViewModel: ObservableObject {
    @Published private(set) var presets: [GradientPreset] = []
    @Published var runningPresetID: UUID?

    private var store: PresetStore
    private var cancellables = Set<AnyCancellable>()

    init(store: PresetStore) {
        self.store = store
        store.$presets.assign(to: \.presets, on: self).store(in: &cancellables)
    }

    func select(_ preset: GradientPreset) {
        // логика запуска применения градиента
        runningPresetID = preset.id
        store.select(by: preset.id)
    }

    func edit(_ preset: GradientPreset) {
        // UI вызовет sheet с переданным preset
    }

    func saveEdited(_ preset: GradientPreset) {
        store.update(preset)
    }

    func saveAsNew(_ preset: GradientPreset) {
        store.duplicate(preset)
    }
}

