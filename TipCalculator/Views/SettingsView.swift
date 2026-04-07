//
//  SettingsView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedOption") private var selectedOption: Int = 0
    @AppStorage("selectedRegion") private var selectedRegion: String = "USA"
    @AppStorage("selectedCurrency") private var selectedCurrency: String = "USD"
    
    private let options: [Int] = [0,1,2,3]
    private let regions: [String] = ["USA", "EUROPE"]
    private let currency: [String] = ["USD", "EUR", "PLN"]
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Region")
                    .font(.headline)
                Picker("Region", selection: $selectedRegion) {
                    ForEach(regions, id: \.self) { region in
                        Text(region).tag(region)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Currency")
                    .font(.headline)
                Picker("Currency", selection: $selectedCurrency) {
                    ForEach(currency, id: \.self) { currency in
                        Text(currency).tag(currency)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Wybierz tło")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
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
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12, style: .continuous)
                                    .stroke(selectedOption == option ? Color.red : Color.clear, lineWidth: 4)
                            )
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
        }
        
    }
}

#Preview {
    SettingsView()
}
