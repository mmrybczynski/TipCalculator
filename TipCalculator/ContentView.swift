//
//  ContentView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

enum Tab {
    case home
    case settings
}

struct ContentView: View {
    @State private var selection: Tab = .home
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(Tab.home)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
}
