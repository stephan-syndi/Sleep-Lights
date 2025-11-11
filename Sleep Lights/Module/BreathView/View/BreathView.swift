//
//  BreathView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
internal import Combine

struct BreathView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var viewModel: BreathViewModel
    
    init(model: BreathModel){
        _viewModel = StateObject(wrappedValue: BreathViewModel(model: model))
    }
    
    var body: some View {
        ZStack{
            themeManager.backgroundGradient.ignoresSafeArea()
            
            Form{
                Picker("Breath", selection: $viewModel.currentTheme){
                    ForEach(viewModel.model.theme, id: \.self){ preset in
                        Text(preset)
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                
                
                Section("Presets"){
                    
                    CustomizeItemView(value: $viewModel.inhaleValue)
                    CustomizeItemView(value: $viewModel.inhaleHold)
                    CustomizeItemView(value: $viewModel.exhaleValue)
                    CustomizeItemView(value: $viewModel.exhaleHold)
                    
                    
                    HStack(spacing: 16){
                        Spacer()
                        Button()
                        {
                            viewModel.applyCustomPreset()
                        } label: {
                            Text("Apply")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 17)
                        .background(.green)
                        .clipShape(Capsule())
                        
                        Button()
                        {
                            viewModel.resetPreset()
                        } label: {
                            Text("Reset")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 17)
                        .background(.red)
                        .clipShape(Capsule())
                    }
                }
                .listRowBackground(Color.white.opacity(0.1))
                .disabled(viewModel.currentTheme != viewModel.model.theme[3])
            }
            .modifier(ContainerHiddenBackground())
        }
        
        
    }
}

#Preview {
    BreathView(model: BreathModel())
        .environmentObject(ThemeManager(store: PresetStore()))
}
