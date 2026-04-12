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
            self.settings.contactAccess = true
            self.settings.hasCheckedPermissions = true
        case .notDetermined:
            print("not determined")
            requestContactAccess()
        case .denied, .restricted:
            print("denied restricted")
            self.hasContactsAccess = false
            self.settings.contactAccess = false
            self.settings.hasCheckedPermissions = true
        @unknown default:
            print("default")
            self.hasContactsAccess = false
            self.settings.contactAccess = false
            self.settings.hasCheckedPermissions = true
        }
    }
    
    private func requestContactAccess() {
        CNContactStore().requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                self.hasContactsAccess = granted
                self.settings.contactAccess = true
                self.settings.hasCheckedPermissions = true
            }
        }
    }
}

#Preview {
    ContentView()
}
