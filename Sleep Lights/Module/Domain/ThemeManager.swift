//
//  ThemeManager.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI
internal import Combine

final class ThemeManager: ObservableObject {
    @Published var backgroundGradient: AnyView = AnyView(Color.clear) // view-ready gradient

    private var cancellables = Set<AnyCancellable>()

    init(store: PresetStore) {
        // Подписываемся на изменения activePresetID и presets (на случай, если preset поменялся)
        Publishers.CombineLatest(store.$activePresetID, store.$presets)
            .receive(on: DispatchQueue.main)
            .sink { [weak self, weak store] activeID, _ in
                guard let self = self, let store = store else { return }
                self.apply(preset: store.currentPreset)
            }
            .store(in: &cancellables)
    }

    private func apply(preset: GradientPreset?) {
        // Маппим модель в view-ready AnyView
        let view: AnyView
        if let preset = preset {
            let colors = preset.colors.map { $0.toColor() }
            
            switch preset.kind {
            case .linear:
                view = AnyView(
                   
                    LinearAnimationView(colors: colors)
                )
            case .radial:
                view = AnyView(
                    RadialAnimationView(colors: colors)
                )
            case .angular:
                view = AnyView(
                    AngularAnimationView(colors: colors)
                )
            }
        } else {
            view = AnyView(Color(UIColor.systemBackground))
        }

        // анимированная смена фона
        withAnimation(.easeInOut(duration: 0.35)) {
            self.backgroundGradient = view
        }
    }
}
