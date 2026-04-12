//
//  MainView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct MainView: View {
    @StateObject private var settings = AppSettings.shared
    
    var body: some View {
        ZStack {
            BackgroundView(selectedBackground: settings.selectedOption)
            VStack {
                Text("\(settings.selectedOption)")
                
            }
        }
        
    }
}

#Preview {
    MainView()
}
