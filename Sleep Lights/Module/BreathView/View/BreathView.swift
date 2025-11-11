//
//  BreathView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
internal import Combine

struct BreathView: View {
    @State private var viewModel: BreathViewModel = BreathViewModel()
    
    
    var body: some View {
        Form{
                Picker("Breath", selection: $viewModel.currentTheme){
                    ForEach(viewModel.model.theme, id: \.self){ preset in
                        Text(preset)
                    }
                }
            
            Section("Presets"){
                
                CustomizeItemView(value: $viewModel.inhaleValue)
                CustomizeItemView(value: $viewModel.inhaleHold)
                CustomizeItemView(value: $viewModel.exhaleValue)
                CustomizeItemView(value: $viewModel.exhaleHold)
                
                
                HStack(spacing: 16){
                    Spacer()
                    Button("Apply")
                    {
                            
                    }
                    .buttonStyle(.borderedProminent)
                        
                    Button("Cancel")
                    {
                            
                    }
                    .buttonStyle(.bordered)
                }
            }.disabled(viewModel.currentTheme != viewModel.model.theme[3])
            
        }
        
        
    }
}

#Preview {
    BreathView()
}
