//
//  PresetListView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct PresetListView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var store: PresetStore
    @StateObject var vm: PresetListViewModel
    
    @State private var editPreset: GradientPreset?
    @State private var isEditorPresented = false
    
    init(_ presetStore: PresetStore) {
        _store = StateObject(wrappedValue: presetStore)
        _vm = StateObject(wrappedValue: PresetListViewModel(store: presetStore))
    }
    
    var body: some View {
        ZStack{
            themeManager.backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200), spacing: 12)], spacing: 12) {
                    ForEach(vm.presets) { p in
                        PresetCardView(
                            preset: p,
                            isRunning: vm.runningPresetID == p.id,
                            onSelect: { preset in vm.select(preset) },
                            onEdit: { preset in
                                editPreset = preset
                                isEditorPresented = true
                            },
                            onSaveAsNew: { preset in vm.saveAsNew(preset) }
                        )
                    }
                }
                .padding()
            }
            .sheet(isPresented: $isEditorPresented, onDismiss: { editPreset = nil }) {
                if let editing = editPreset {
                    GradientEditorView(preset: editing) { changed in
                        vm.saveEdited(changed)
                        isEditorPresented = false
                    }
                } else {
                    EmptyView()
                }
            }
            .navigationTitle("Presets")
            .padding(.bottom, 50)
        }
    }
}


#Preview {
    PresetListView(PresetStore())
        .environmentObject(SettingsManager())
        .environmentObject(ThemeManager(store: PresetStore()))
}
