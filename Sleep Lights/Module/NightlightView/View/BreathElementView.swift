//
//  BreathElementView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import SwiftUI

struct BreathElementView: View {
    @EnvironmentObject private var presetStore: PresetStore
    @ObservedObject var vm: NightlightViewModel
    
    
    var body: some View {
        VStack{
            Spacer()
            ZStack(){
            
                Circle()
                    .fill(presetStore.currentPreset?.ringColor.fill.toColor() ?? .sunsetFill)
                    .frame(width: vm.model.circleSize, height: vm.model.circleSize)
                
                Circle()
                    .stroke(presetStore.currentPreset?.ringColor.accentSecondary.toColor() ?? .sunsetAccentSecondary, lineWidth: 14)
                    .frame(width: vm.model.circleSize * vm.scale, height: vm.model.circleSize * vm.scale)
                    .blur(radius: 3)
                    .animation(.easeInOut(duration: vm.currrentDuration), value: vm.scale)
                
                Circle()
                    .stroke(presetStore.currentPreset?.ringColor.accent.toColor() ?? .sunsetAccent, lineWidth: 10)
                    .frame(width: vm.model.circleSize * vm.scale, height: vm.model.circleSize * vm.scale)
                    .shadow(color: presetStore.currentPreset?.ringColor.glow.toColor() ?? .sunsetGlow, radius: 20 * vm.scale, x: 0, y: 8 * vm.scale)
                    .animation(.easeInOut(duration: vm.currrentDuration), value: vm.scale)
                
                Text(vm.label)
                    .font(.title2.weight(.semibold))
                    .foregroundColor(presetStore.currentPreset?.ringColor.textColor.toColor())
            }
            .frame(height: vm.model.circleSize * vm.model.maxScale)
            
            HStack(spacing: 16){
                Button("Reset"){
                    vm.onStop()
                    withAnimation(.easeInOut(duration: 0.2)){
                        vm.onSetDefault()
                    }
                }
                .frame(maxHeight: 100)
                .buttonStyle(.bordered)
            }
            .onDisappear{ vm.onStop()}
            .onAppear {
                vm.scale = vm.model.minScale
            }
            
            Spacer()
            
            VStack(alignment: .center, spacing: 8){
                Text("Long press — hide or show the timer.")
                Text("Swipe up / down — adjust scene brightness.")
                Text("Double tap — pause / resume the breathing animation.")
            }
            .font(.caption)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
            .background(.mainBG.opacity(0.25))
            .clipShape(Capsule())
            .foregroundColor(.white)
                
            
        }
    }
}

#Preview {
    BreathElementView(vm: NightlightViewModel(manager: TimeManager(), breath: BreathModel()))
        .environmentObject(PresetStore())
}
