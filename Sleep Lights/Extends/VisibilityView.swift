//
//  VisibilityView.swift
//  Sleep Lights
//
//  Created by Stepan Degtsiaryk on 31.10.25.
//

import SwiftUI
enum ViewVisibility {
    case visible, invisible, gone
}

extension View {
    @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
        switch visibility {
        case .visible:
            self
        case .invisible:
            self.hidden()
        case .gone:
            EmptyView()
        }
    }
}
