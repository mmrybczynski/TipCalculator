//
//  ContentView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI
import Contacts

enum Tab {
    case home
    case settings
    case settingsContact
}

struct ContentView: View {
    @State private var selection: Tab = .home
    @State private var hasContactsAccess: Bool = false
    @Environment(\.scenePhase) var scenePhase
    
    @ObservedObject var settings = AppSettings.shared
    
    var body: some View {
        
        #if os(iOS)
        TabView(selection: $selection) {
            MainView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(Tab.home)
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
                .tag(Tab.settings)
        }
        .onAppear {
            checkContactPermission()
        }
        .onChange(of: scenePhase) {_, newPhase in
            if newPhase == .active {
                checkContactPermission()
            }
        }
        #endif
    }
    
    private func checkContactPermission() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized, .limited:
            print("authorized")
            self.hasContactsAccess = true
            settings.contactAccess = true
            settings.hasCheckedPermissions = true
        case .notDetermined:
            print("not determined")
            requestContactAccess()
        case .denied, .restricted:
            print("denied restricted")
            self.hasContactsAccess = false
            settings.contactAccess = false
            settings.hasCheckedPermissions = true
        @unknown default:
            print("default")
            self.hasContactsAccess = false
            settings.contactAccess = false
            settings.hasCheckedPermissions = true
        }
    }
    
    private func requestContactAccess() {
        CNContactStore().requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                self.hasContactsAccess = granted
                settings.contactAccess = true
                settings.hasCheckedPermissions = true
            }
        }
    }
}

#Preview("Access granted") {
    let s = AppSettings.shared
    s.contactAccess = true
    s.hasCheckedPermissions = true
    return ContentView()
}

#Preview("Access denied") {
    let s = AppSettings.shared
    s.contactAccess = false
    s.hasCheckedPermissions = true
    return ContentView()
}
