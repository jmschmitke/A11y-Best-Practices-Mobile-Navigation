import SwiftUI

//Extension für minimale Touch-Target-Größe
extension View {
    func minTouchTargetSize() -> some View {
        self.frame(minWidth: 44, minHeight: 44)
    }
}

struct EventDetailView: View {
    let event: CampusEvent
    
    // Formular-Zustände für Name und E-Mail
    @State private var name: String = ""
    @State private var email: String = ""
    
    // PATTERN 10: Fehlermeldungen & Fokus-Steuerung
    @State private var nameError: String? = nil
    @State private var emailError: String? = nil
    
    enum FormField {
        case name, email
    }
    @FocusState private var focusedField: FormField?
    
    // PATTERN 3: Status für Popup
    @State private var showConfirmationModal: Bool = false
    @State private var registrationSuccess: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Kategorie für Event
                Text(event.tag.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.accentColor.opacity(0.15))
                    .foregroundStyle(Color.accentColor)
                    .clipShape(Capsule())
                
                // Titel für Event
                Text(event.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                // Weitere Event-Infos
                VStack(alignment: .leading, spacing: 10) {
                    Label(event.date, systemImage: "calendar")
                    Label(event.location, systemImage: "mappin.and.ellipse")
                }
                .font(.headline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                // Beschreibung de Events
                Text("Über diese Veranstaltung")
                    .font(.title2)
                    .fontWeight(.bold)
                    .accessibilityAddTraits(.isHeader)
                
                Text(event.description)
                    .font(.body)
                    .lineSpacing(4)
                
                Divider()
                    .padding(.vertical, 8)
                
                // PATTERN 10: Anmeldeformular mit Eingabefehlern
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Für Event anmelden")
                        .font(.title2)
                        .fontWeight(.bold)
                        .accessibilityAddTraits(.isHeader)
                    
                    if registrationSuccess {
                        // Erfolgsmeldung nach Bestätigung im Popup
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                                .font(.title2)
                            Text("Du bist erfolgreich für dieses Event angemeldet!")
                                .font(.headline)
                                .foregroundColor(.green)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    } else {
                        // Namensfeld
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Vollständiger Name")
                                .font(.headline)
                            
                            TextField("Max Mustermann", text: $name)
                                .textContentType(.name)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(nameError != nil ? Color.red : Color.secondary)
                                )
                                .accessibilityLabel(nameError != nil ? "Fehler: Vollständiger Name" : "Vollständiger Name")
                                .accessibilityHint(nameError ?? "")
                                .focused($focusedField, equals: .name)
                            
                            if let error = nameError {
                                HStack(spacing: 6) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                    Text(error)
                                        .foregroundColor(.red)
                                        .font(.callout)
                                }
                                .accessibilityHidden(true)
                            }
                        }
                        
                        // E-Mail-Feld
                        VStack(alignment: .leading, spacing: 6) {
                            Text("E-Mail-Adresse")
                                .font(.headline)
                            
                            TextField("beispiel@domain.de", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .textContentType(.emailAddress)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(emailError != nil ? Color.red : Color.secondary)
                                )
                                .accessibilityLabel(emailError != nil ? "Fehler: E-Mail-Adresse" : "E-Mail-Adresse")
                                .accessibilityHint(emailError ?? "")
                                .focused($focusedField, equals: .email)
                            
                            if let error = emailError {
                                HStack(spacing: 6) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                    Text(error)
                                        .foregroundColor(.red)
                                        .font(.callout)
                                }
                                .accessibilityHidden(true)
                            }
                        }
                        
                        // Anmelde-Button
                        Button(action: validateAndSubmit) {
                            Text("Jetzt verbindlich anmelden")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .minTouchTargetSize()
                                .background(Color.accentColor)
                                .cornerRadius(12)
                        }
                        .padding(.top, 8)
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Event Details")
        .navigationBarTitleDisplayMode(.inline)
        // PATTERN 3: Popup zur Bestätigung der Anmeldung
        .sheet(isPresented: $showConfirmationModal) {
            EventRegistrationModalView(
                isPresented: $showConfirmationModal,
                eventTitle: event.title,
                userName: name,
                userEmail: email,
                onConfirm: {
                    registrationSuccess = true
                }
            )
            .interactiveDismissDisabled(true) // Verhindert versehentliches Wischen nach unten
        }
    }
    
    // PATTERN 10: Validierungslogik
    private func validateAndSubmit() {
        // Reset bisheriger Fehler
        nameError = nil
        emailError = nil
        
        var hasError = false
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = "Bitte geben Sie Ihren vollständigen Namen ein."
            focusedField = .name
            hasError = true
        }
        
        if !email.contains("@") || email.count < 5 {
            emailError = "Bitte geben Sie eine gültige E-Mail-Adresse ein (z.B. name@domain.de)."
            if !hasError {
                focusedField = .email
            }
            hasError = true
        }
        
        if hasError {
            AccessibilityNotification.Announcement("Formular konnte nicht gesendet werden. Bitte prüfen Sie die Eingaben.")
                .post()
        } else {
            // Keine Fehler -> Popup öffnen
            showConfirmationModal = true
        }
    }
}

// ATTERN 3: Popup
struct EventRegistrationModalView: View {
    @Binding var isPresented: Bool
    let eventTitle: String
    let userName: String
    let userEmail: String
    let onConfirm: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.accentColor)
                        .padding(.top, 10)
                    
                    Text("Möchtest du die Anmeldung für **\(eventTitle)** wirklich abschließen?")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Angemeldete Person:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(userName)
                            .font(.headline)
                        Text(userEmail)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    
                    // Haupt-Aktionsbutton
                    Button(action: {
                        onConfirm()
                        isPresented = false
                    }) {
                        Text("Anmeldung verbindlich bestätigen")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .minTouchTargetSize()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Alternativer Abbrechen-Button
                    Button(action: { isPresented = false }) {
                        Text("Abbrechen")
                            .font(.body)
                            .foregroundColor(.red)
                            .padding()
                            .minTouchTargetSize()
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Anmeldung bestätigen")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundColor(.secondary)
                            .frame(width: 44, height: 44)
                    }
                    .accessibilityLabel("Schließen")
                }
            }
        }
    }
}

#Preview {
    EventDetailView(
        event: CampusEvent(
            title: "Semester-Opening-Party",
            date: "15. Okt, 21:00 Uhr",
            location: "Campus Club",
            description: "Feiert mit uns den Start ins neue Semester! DJs, Drinks und gute Laune.",
            tag: "Party"
        )
    )
}
