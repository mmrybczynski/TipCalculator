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
    @State private var hasContactAccess: Bool = false
    @State private var showContactPicker: Bool = false
    @State private var showMessageComposer: Bool = false
    @State private var selectedContacts: [SelectedContact] = []
    @State private var contactToResolve: CNContact?
    @State private var showNumberSelection: Bool = false
    private let predefinedMessage = "Hi, I would like to invite you to join me for a coffee"
    
    var body: some View {
        NavigationStack {
            VStack {
                if hasContactAccess {
                    mainContentView
                } else {
                    permissionView
                }
            }
            .navigationTitle("odbiorcy")
            /*
            .onAppear{
                checkContactsPermission()
            }
            .sheet(isPresented: $showContactPicker) {
                ContactPicker(selectedContacts: $selectedContacts, contactToResolve: $contactToResolve)
                    .ignoresSafeArea()
            }
            .sheet(item: $contactToResolve) { contact in
                PhoneNumberSelectionView(contact: contact) { selectedNumber in
                    let newEntry = SelectedContact(contact: contact, selectedPhoneNumber: selectedNumber)
                    if !selectedContacts.contains(where: { $0.selectedPhoneNumber == selectedNumber }) {
                        selectedContacts.append(newEntry)
                    }
                    contactToResolve = nil
                }
            }
            .sheet(isPresented: $showMessageComposer) {
                MessageComposer(recipients: selectedContacts.map { $0.selectedPhoneNumber }, body: predefinedMessage)
                    .ignoresSafeArea()
            }*/
        }
    }
    
    private var mainContentView: some View {
        VStack {
            HStack {
                Button(action: {showContactPicker = true}) {
                    Label("Dodaj", systemImage: "person.badge.plus")
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {selectedContacts.removeAll()}) {
                    Label("Wyczyść", systemImage: "trash")
                        .frame(maxWidth: .infinity)
                }
            }
            List {
                Section(header: Text("Wybrane numery \(selectedContacts.count)")) {
                    if selectedContacts.isEmpty {
                        Text("Lista jest pusta")
                    } else {
                        ForEach(selectedContacts) { item in
                            HStack {
                                VStack {
                                    Text(item.fullName)
                                    Text(item.selectedPhoneNumber)
                                }
                            }
                        }
                        .onDelete(perform: removeContact)
                    }
                }
            }
            Button {
                if MFMessageComposeViewController.canSendText() {
                    showMessageComposer = true
                }
            } label: {
                HStack {
                    Image(systemName: "parperplane.fill")
                    Text("Wyślij wiadomość")
                }
            }

        }
    }
    
    private var permissionView: some View {
        ContentUnavailableView {
            Label("Brak dostępu", systemImage: "exclamationmark.icloud")
        } description: {
            Text("Nadaj dostęp do kontaktów")
        } actions: {
            Button("Poproś o dostęp") {
                requestContactAccess()
            }
        }
    }
    
    private func removeContact(at offsets: IndexSet) {
        selectedContacts.remove(atOffsets: offsets)
    }
    
    private func checkContactAccess() {
        hasContactAccess = CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }
    
    private func requestContactAccess() {
        CNContactStore().requestAccess(for: .contacts) { granted, _ in
            DispatchQueue.main.async {
                self.hasContactAccess = granted
            }
        }
    }
}

#Preview {
    TestContactView()
}
