//
//  BreathElementView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 30.10.25.
//

import SwiftUI

struct BreathElementView: View {
    @Binding var vm: NightlightViewModel
    
    var body: some View {
        VStack{
            ZStack(){
                
                Circle()
                    .fill(Color.blue.opacity(0.12))
                    .frame(width: vm.model.circleSize, height: vm.model.circleSize)
                
                Circle()
                    .stroke(Color.blue.opacity(0.25), lineWidth: 10)
                    .frame(width: vm.model.circleSize * vm.scale, height: vm.model.circleSize * vm.scale)
                    .shadow(color: Color.red.opacity(0.75), radius: 20 * vm.scale, x: 0, y: 8 * vm.scale)
                    .animation(.easeInOut(duration: vm.currrentDuration), value: vm.scale)
                
                Text(vm.label)
                    .font(.title2.weight(.semibold))
                    .foregroundColor(.primary)
            }
            .frame(height: vm.model.circleSize * vm.model.maxScale)
            
            
            HStack(spacing: 16){
                Button{
                    withAnimation(.easeInOut(duration: 4)){
                        vm.onToggle()
                    }
                }label:{
                    Text(vm.isRunning ? "Stop" : "Start")
                        .frame(minWidth: 100)
                }
                .buttonStyle(.borderedProminent)
                
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
        }
    }
}
