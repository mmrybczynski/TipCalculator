//
//  BackgroundView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct BackgroundView: View {
    let selectedBackground: Int
    var body: some View {
        backgroundForSelection(selectedBackground)
            .ignoresSafeArea()
    }
    @ViewBuilder
    private func backgroundForSelection(_ value: Int) -> some View {
        switch value {
        case 0:
            Color.blue
        case 1:
            LinearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 2:
            RadialGradient(gradient: Gradient(colors: [.orange, .red]),
                           center: .center,
                           startRadius: 20,
                           endRadius: 300)
        case 3:
            AngularGradient(gradient: Gradient(colors: [.mint, .teal, .indigo, .mint]),
                            center: .center)
        default:
            Color.gray.opacity(0.2)
        }
    }
}

#Preview {
    BackgroundView(selectedBackground: 0)
}
