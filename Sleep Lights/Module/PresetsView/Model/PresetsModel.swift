//
//  PresetsModel.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 29.10.25.
//

import SwiftUI
internal import Combine

enum GradientKind: String, Codable, CaseIterable {
    case linear, radial, angular
}

struct GradientPreset: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var kind: GradientKind
    var colors: [ColorCodable] // Codable wrapper for Color
    var ringColor: RingColor
    var startPoint: UnitPointCodable?
    var endPoint: UnitPointCodable?

    init(id: UUID = .init(), name: String, kind: GradientKind = .linear, colors: [Color] = [.red, .orange], ringColor: RingColor = RingColor()) {
        self.id = id
        self.name = name
        self.kind = kind
        self.colors = colors.map { ColorCodable($0) }
        self.ringColor = ringColor
        self.startPoint = UnitPointCodable(.topLeading)
        self.endPoint = UnitPointCodable(.bottomTrailing)
    }
}

// Helpers for Codable Color & UnitPoint
struct ColorCodable: Codable, Equatable {
    var red: Double, green: Double, blue: Double, alpha: Double

    init(_ color: Color) {
        // convert approximate using UIColor
        #if os(iOS)
        let ui = UIColor(color)
        var r: CGFloat=0,g:CGFloat=0,b:CGFloat=0,a:CGFloat=0
        ui.getRed(&r, green: &g, blue: &b, alpha: &a)
        red = Double(r); green = Double(g); blue = Double(b); alpha = Double(a)
        #else
        red = 1; green = 0; blue = 0; alpha = 1
        #endif
    }

    func toColor() -> Color {
        Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct UnitPointCodable: Codable, Equatable {
    var x: Double, y: Double
    init(_ p: UnitPoint) { x = Double(p.x); y = Double(p.y) }
    func toUnitPoint() -> UnitPoint { UnitPoint(x: x, y: y) }
}

struct RingColor: Codable, Equatable {
    var fill: ColorCodable
    var accent: ColorCodable
    var accentSecondary: ColorCodable
    var glow: ColorCodable
    var textColor: ColorCodable
    
    init(_ fill: Color = .sunsetFill, _ accent: Color = .sunsetAccent, _ accentSecondary: Color = .sunsetAccentSecondary, _ glow: Color = .sunsetGlow, _ textColor: Color = .white) {
        self.fill = ColorCodable(fill)
        self.accent = ColorCodable(accent)
        self.accentSecondary = ColorCodable(accentSecondary)
        self.glow = ColorCodable(glow)
        self.textColor = ColorCodable(textColor)
    }
}
