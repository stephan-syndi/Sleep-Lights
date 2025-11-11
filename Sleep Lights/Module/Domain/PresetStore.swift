//
//  PresetStore.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI
internal import Combine

final class PresetStore: ObservableObject {
    @Published private(set) var presets: [GradientPreset] = []
    @Published var activePresetID: UUID?
    
    private let activeKey = "gradient.activePreset.v1"
    private let key = "gradient.presets.v1"
    private var cancellables = Set<AnyCancellable>()
    
    init(loadDefaultIfEmpty: Bool = true) {
        load()
        if presets.isEmpty && loadDefaultIfEmpty {
            presets = [
                GradientPreset(name: "Sunset", colors: [.sunsetFirst, .sunsetSecond, .sunsetThird], ringColor: RingColor()),
                GradientPreset(name: "Ocean", colors: [.oceanFirst, .oceanSecond, .oceanThird], ringColor: RingColor(.oceanFill, .oceanAccent, .oceanAccentSecondary, .oceanGlow, .gray.opacity(0.6))),
                GradientPreset(name: "Aurora", colors: [.auroraFirst, .auroraSecond, .auroraThird], ringColor: RingColor(.auroraFill, .auroraAccent, .auroraAccentSecondary, .auroraGlow, .gray.opacity(0.5))),
                GradientPreset(name: "Ember", colors: [.emberFirst, .emberSecond, .emberThird], ringColor: RingColor(.emberFill, .emberAccent, .emberAccentSecondary, .emberGlow, .white)),
                GradientPreset(name: "Lavender", colors: [.purple, .pink])
            ]
        }
        
        if let data = UserDefaults.standard.string(forKey: activeKey),
           let uuid = UUID(uuidString: data){
            activePresetID = uuid
            if !presets.contains(where: {$0.id == uuid}){
                activePresetID = presets[0].id
            }
        }
        
        // auto-save
        $presets
            .dropFirst()
            .debounce(for: .milliseconds(150), scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.savePresets() }
            .store(in: &cancellables)
        
        $activePresetID
            .dropFirst()
            .debounce(for: .milliseconds(100), scheduler: RunLoop.main)
            .sink{ [weak self] id in
                self?.saveActive(id)
            }
            .store(in: &cancellables)
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([GradientPreset].self, from: data) else { return }
        presets = decoded
        
    }
    
    private func savePresets() {
        DispatchQueue.global(qos: .background).async {
            [presets] in
            if let encoded = try? JSONEncoder().encode(presets){
                UserDefaults.standard.set(encoded, forKey: self.key)
            }
        }
    }
    
    private func saveActive(_ id: UUID?){
        DispatchQueue.global(qos: .background).async {
            if let id = id{
                UserDefaults.standard.set(id.uuidString, forKey: self.activeKey)
            } else {
                UserDefaults.standard.removeObject(forKey: self.activeKey)
            }
        }
    }
    
    // CRUD
    func add(_ preset: GradientPreset) {
        presets.insert(preset, at: 0)
    }
    
    func update(_ preset: GradientPreset) {
        guard let idx = presets.firstIndex(where: { $0.id == preset.id }) else { return }
        presets[idx] = preset
    }
    
    func remove(id: UUID) {
        presets.removeAll { $0.id == id }
        if activePresetID == id {activePresetID = nil}
    }
    
    func duplicate(_ preset: GradientPreset, newName: String? = nil) -> GradientPreset {
        let copy = GradientPreset(name: newName ?? "\(preset.name) Copy", kind: preset.kind, colors: preset.colors.map({ item in
            item.toColor()
        }))
        add(copy)
        return copy
    }
    
    // MARK: - active selection helpers
    var currentPreset: GradientPreset? {
        guard let id = activePresetID else { return nil}
        return presets.first(where: { $0.id == id})
    }
        
    func select(by id: UUID){
        guard presets.contains(where: {$0.id == id}) else {return}
        activePresetID = id
    }
    
    func clearActive(){
        activePresetID = nil
    }
    
    func toggle(_ preset: GradientPreset) {
        if activePresetID == preset.id { clearActive() }
        else { select(by: preset.id) }
    }
    
}

