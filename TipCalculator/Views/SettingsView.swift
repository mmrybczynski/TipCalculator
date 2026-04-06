//
//  SettingsView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedOption") private var selectedOption: Int = 0
    private let options: [Int] = [0,1,2,3]
    
    var body: some View {
        HStack {
            ForEach(options, id: \.self) { option in
                VStack {
                    BackgroundView(selectedBackground: option)
                }
                .frame(width: 50, height: 100)
                .onTapGesture {
                    selectedOption = option
                    print(option)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
