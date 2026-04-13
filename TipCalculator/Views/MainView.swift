//
//  MainView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 4/6/2026.
//

import SwiftUI

struct MainView: View {
    @StateObject private var settings = AppSettings.shared
    @State private var selectedTip:Int = 5
    
    private let tips:[Int] = [0,5,10, 15, 20, 25, 30]
    
    var body: some View {
        ZStack {
            BackgroundView(selectedBackground: settings.selectedOption)
            VStack(alignment: .leading) {
                if settings.contactAccess {
                    Text("access")
                }
                HStack {
                    Text(settings.selectedCurrency)
                        .padding(.trailing, 5)
                    TextField("Podaj kwotę", text: .constant(""))
                        .keyboardType(.decimalPad)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                .padding(.bottom,10)
                
                if settings.contactAccess {
                    Text("access")
                } else {
                    HStack {
                        Image(systemName: "person.fill")
                            .padding(.trailing, 5)
                        TextField("Ile osób", text: .constant(""))
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .padding(.bottom,10)
                }
                
                Text("Jaki tip?")
                Picker("Tip", selection: $selectedTip) {
                    ForEach(tips, id: \.self) { tip in
                        Text("\(tip)%").tag(tip)
                    }
                }
                .pickerStyle(.segmented)
                
            }
            .padding()
        }
        
    }
}

#Preview("Access granted") {
    let s = AppSettings.shared
    s.contactAccess = true
    return MainView()
}

#Preview("Access denied") {
    let s = AppSettings.shared
    s.contactAccess = false
    return MainView()
}
