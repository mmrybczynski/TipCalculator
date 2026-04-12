//
//  TestContactView.swift
//  TipCalculator
//
//  Created by Mateusz Rybczyński on 12/04/2026.
//

import SwiftUI
import Contacts
import ContactsUI
import MessageUI

struct SelectedContact: Identifiable, Equatable {
    let id = UUID()
    let contact: CNContact
    var selectedPhoneNumber: String
    
    var fullName: String {
        "\(contact.givenName) \(contact.familyName)"
    }
}

struct TestContactView: View {
    
    private let predefinedMessage = "Hi, I would like to invite you to join me for a coffee"
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TestContactView()
}
