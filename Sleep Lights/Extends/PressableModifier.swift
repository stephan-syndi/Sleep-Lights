//
//  PressableModifier.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 7.11.25.
//

import SwiftUI

struct PressableModifier: ViewModifier{
    var scale: CGFloat = 0.96
    var pressedOpacity: Double = 0.85
    var animation: Animation = .spring(response: 0.25, dampingFraction: 0.7, blendDuration: 0)
    
    @GestureState private var isPressing = false
    
    func body(content: Content) -> some View {
        let pressGesture = LongPressGesture(minimumDuration: 0.01)
            .updating($isPressing){ value, state, _ in
                state = value
            }
        
        content
            .scaleEffect(isPressing ? scale : 1)
            .opacity(isPressing ? pressedOpacity : 1)
            .animation(animation, value: isPressing)
            .gesture(pressGesture)
    }
}

extension View {
    func pressable(scale: CGFloat = 0.96, pressedOpacity: Double = 0.85, animation: Animation = .spring(response: 0.25, dampingFraction: 0.7, blendDuration: 0)) -> some View {
        modifier(PressableModifier(scale: scale, pressedOpacity: pressedOpacity, animation: animation))
    }
    
}
