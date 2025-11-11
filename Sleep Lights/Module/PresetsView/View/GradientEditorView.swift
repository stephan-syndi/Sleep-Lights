//
//  GradientEditorView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI
internal import Combine

struct GradientEditorView: View {
    @State var preset: GradientPreset
    var onSave: (GradientPreset) -> Void
    @Environment(\.presentationMode) var dismiss

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Preset name", text: $preset.name)
                }

                Section(header: Text("Colors")) {
                    ForEach(preset.colors.indices, id: \.self) { idx in
                        // заранее создаём binding с явным типом
                        let colorBinding: Binding<Color> = Binding<Color>(
                            get: { preset.colors[idx].toColor() },
                            set: { newColor in
                                preset.colors[idx] = ColorCodable(newColor)
                            }
                        )

                        ColorPicker("Color \(idx + 1)", selection: colorBinding)
                    }

                    Button("Add Color") {
                        preset.colors.append(ColorCodable(.gray))
                    }
                    if preset.colors.count > 2 {
                        Button("Remove Last Color") { _ = preset.colors.popLast() }
                            .foregroundColor(.red)
                    }
                }
                
                Section(header: Text("Ring Colors")){
                    let fillBinding: Binding<Color> = Binding<Color>(
                        get: { preset.ringColor.fill.toColor() },
                        set: { newColor in
                            preset.ringColor.fill = ColorCodable(newColor)
                        }
                    )
                    
                    ColorPicker("Color Fill", selection: fillBinding)
                    
                    // MARK: -
                    let accentBinding: Binding<Color> = Binding<Color>(
                        get: { preset.ringColor.accent.toColor() },
                        set: { newColor in
                            preset.ringColor.accent = ColorCodable(newColor)
                        }
                    )
                    
                    ColorPicker("Color Accent", selection: accentBinding)
                    // MARK: -
                    let accentSecondBinding: Binding<Color> = Binding<Color>(
                        get: { preset.ringColor.accentSecondary.toColor() },
                        set: { newColor in
                            preset.ringColor.accentSecondary = ColorCodable(newColor)
                        }
                    )
                    
                    ColorPicker("Color Accent Secondary", selection: accentSecondBinding)
                    
                    // MARK: -
                    let glowBinding: Binding<Color> = Binding<Color>(
                        get: { preset.ringColor.glow.toColor() },
                        set: { newColor in
                            preset.ringColor.glow = ColorCodable(newColor)
                        }
                    )
                    
                    ColorPicker("Color Glow", selection: glowBinding)
                    
                }

                Section(header: Text("Type")) {
                    Picker("Kind", selection: $preset.kind) {
                        ForEach(GradientKind.allCases, id: \.self) { kind in
                            Text(kind.rawValue.capitalized).tag(kind)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Edit Preset", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss.wrappedValue.dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(preset)
                    }
                }
            }
        }
    }
}
