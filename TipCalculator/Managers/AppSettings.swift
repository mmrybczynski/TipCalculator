//
//  AppSettings.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 12/04/2026.
//

import Foundation
import SwiftUI
import Combine

class AppSettings: ObservableObject {
    @AppStorage("selectedOption") var selectedOption: Int = 0
    @AppStorage("selectedRegion") var selectedRegion: String = "USA"
    @AppStorage("selectedCurrency") var selectedCurrency: String = "USD"
    @AppStorage("hasCheckedPermissions") var hasCheckedPermissions: Bool = false
    @AppStorage("contactAccess") var contactAccess: Bool = false
    
    static let shared = AppSettings()
    
    private init() {}
}
