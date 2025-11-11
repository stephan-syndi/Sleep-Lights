//
//  PresetCardView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct PresetCardView: View {
    let preset: GradientPreset
    let isRunning: Bool
    let onSelect: (GradientPreset) -> Void
    let onEdit: (GradientPreset) -> Void
    let onSaveAsNew: (GradientPreset) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(preset.name)
                    .font(.headline)
                Spacer()
                Button(action: { onSelect(preset) }) {
                    Image(systemName: "play.circle")
                }
                .buttonStyle(BorderlessButtonStyle())
                Menu {
                    Button("Edit") { onEdit(preset) }
                    Button("Save as New") { onSaveAsNew(preset) }
                } label: {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .padding(.leading, 6)
                }
                .menuStyle(BorderlessButtonMenuStyle())
            }
            gradientPreview
                .frame(height: 120)
                .cornerRadius(12)
                .overlay(
                    Group {
                        if isRunning {
                            Image(systemName: "play.fill")
                                .padding(8)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                                .offset(x: -8, y: -8)
                        }
                    }, alignment: .bottomTrailing
                )
           
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 14).fill(Color(UIColor.secondarySystemBackground).opacity(0.5)))
        .onTapGesture { onSelect(preset) }
    }

    @ViewBuilder
    private var gradientPreview: some View {
        let uiColors = preset.colors.map { $0.toColor() }
        switch preset.kind {
        case .linear:
            LinearGradient(colors: uiColors,
                           startPoint: preset.startPoint?.toUnitPoint() ?? .topLeading,
                           endPoint: preset.endPoint?.toUnitPoint() ?? .bottomTrailing)
        case .radial:
            RadialGradient(gradient: Gradient(colors: uiColors),
                           center: .center, startRadius: 5, endRadius: 120)
        case .angular:
            AngularGradient(gradient: Gradient(colors: uiColors), center: .center)
        }
    }
}
