//
//  RootSceen.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 5.11.25.
//

import SwiftUI
internal import Combine

enum RootScreen{
    case main, nightlight
}

final class AppState: ObservableObject {
    @Published var root: RootScreen = .main
}
