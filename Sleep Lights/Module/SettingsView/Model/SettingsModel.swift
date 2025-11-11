//
//  SettingsModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 6.11.25.
//

import SwiftUI
import Foundation
internal import Combine

import Foundation

enum GradientType: String, CaseIterable, Codable {
    case linear, radial, angular
}

enum AnimationSpeed: String, CaseIterable, Codable {
    case slow, medium, fast
}

enum DriftAmplitude: String, CaseIterable, Codable {
    case off, low, medium
}

enum AppTheme: String, CaseIterable, Codable {
    case system, darkOnly = "dark_only"
}

struct AppSettings: Codable, Equatable {
    var gradientType: GradientType = .linear
    var animationSpeed: AnimationSpeed = .medium
    var driftAmplitude: DriftAmplitude = .off
    var defaultTimerSeconds: Int = 60
    var theme: AppTheme = .darkOnly
    var notificationsEnabled: Bool = false
}
