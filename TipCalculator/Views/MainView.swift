//
//  MainView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct MainView: View {
    @AppStorage("selectedOption") private var selectedOption:Int = 0
    
    var body: some View {
        ZStack {
            BackgroundView(selectedBackground: selectedOption)
            VStack {
                Text("\(selectedOption)")
                
            }
        }
        
    }
}

#Preview {
    MainView()
}
