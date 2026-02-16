//
//  MainContentView.swift
//  SleepLights
//
//  Created by Stepan Degtsiaryk on 16.02.26.
//

import SwiftUI
import DarkCoreFramework

struct MainContentView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        router.changeScreen()
    }
}

