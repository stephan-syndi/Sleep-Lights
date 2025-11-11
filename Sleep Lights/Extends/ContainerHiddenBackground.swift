//
//  ContainerHiddenBackground.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 1.11.25.
//

import Foundation
import SwiftUI

struct ContainerHiddenBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
            .onDisappear(){
                UITableView.appearance().backgroundColor = .systemGroupedBackground
            }
        }
    }
}
