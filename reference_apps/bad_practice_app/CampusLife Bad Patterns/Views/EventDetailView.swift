import SwiftUI

struct EventDetailView: View {
    let event: CampusEvent
    
    // Formular-Zustände für Name und E-Mail
    @State private var name: String = ""
    @State private var email: String = ""
    
    // PATTERN 10: Fehlermeldungen als Boolean
    @State private var hasNameError: Bool = false
    @State private var hasEmailError: Bool = false
    
    // PATTERN 3: Status für Popup
    @State private var showConfirmationModal: Bool = false
    @State private var registrationSuccess: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Kategorie für Events
                Text(event.tag.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.accentColor.opacity(0.15))
                    .foregroundStyle(Color.accentColor)
                    .clipShape(Capsule())
                
                // Titel für Events
                Text(event.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    // BARRIERE: Keine Deklaration als Überschrift
                
                // Weitere Infos für Events
                VStack(alignment: .leading, spacing: 10) {
                    Label(event.date, systemImage: "calendar")
                    Label(event.location, systemImage: "mappin.and.ellipse")
                }
                .font(.headline)
                .foregroundStyle(.secondary)
                
                Divider()
                
                // Beschreibung des Events
                Text("Über diese Veranstaltung")
                    .font(.title2)
                    .fontWeight(.bold)
                    // BARRIERE: Keine Deklaration als Überschrift
                
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
                    
                    if registrationSuccess {
                        // Erfolgsmeldung
                        HStack(spacing: 10) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("Erfolgreich angemeldet!")
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
                            
                            // BARRIERE: Fehler wird ausschließlich über die Farbe Rot signalisiert. Kein Fehlermeldungs-Text, kein AccessibilityLabel, kein AccessibilityHint
                            TextField("Max Mustermann", text: $name)
                                .padding()
                                .border(hasNameError ? Color.red : Color.gray, width: 2)
                        }
                        
                        // E-Mail-Feld
                        VStack(alignment: .leading, spacing: 6) {
                            Text("E-Mail-Adresse")
                            
                            // BARRIERE: Fehler wird ausschließlich über die Farbe Rot signalisiert. Kein Fehlermeldungs-Text, kein AccessibilityLabel, kein AccessibilityHint
                            TextField("beispiel@domain.de", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .padding()
                                .border(hasEmailError ? Color.red : Color.gray, width: 2)
                        }
                        
                        // Anmelde-Button
                        Button(action: validateAndSubmit) {
                            Text("Jetzt verbindlich anmelden")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                // BARRIERE: Touch-Target zu klein
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
        .navigationBarTitleDisplayMode(.inline)
        // PATTERN 3: Schlechtes Modales Popup
        .sheet(isPresented: $showConfirmationModal) {
            EventRegistrationBadModalView(
                isPresented: $showConfirmationModal,
                eventTitle: event.title,
                userName: name,
                userEmail: email,
                onConfirm: {
                    registrationSuccess = true
                }
            )
        }
    }
    
    // PATTERN 10: Validierungslogik
    private func validateAndSubmit() {
        hasNameError = false
        hasEmailError = false
        var hasError = false
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            hasNameError = true
            hasError = true
        }
        
        if !email.contains("@") || email.count < 5 {
            hasEmailError = true
            hasError = true
        }
        
        // BARRIERE: Statusänderung wird asynchron nicht angesagt. Fokus wird bei einem Fehler nicht auf das fehlerhafte Textfeld gesetzt
        if !hasError {
            showConfirmationModal = true
        }
    }
}

// PATTERN 3: Popup
struct EventRegistrationBadModalView: View {
    @Binding var isPresented: Bool
    let eventTitle: String
    let userName: String
    let userEmail: String
    let onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            
            // BARRIERE: Keine Deklaration als Überschrift
            Text("Anmeldung bestätigen")
                .font(.title2)
                .bold()
                .padding(.top, 20)
            
            Text("Möchtest du die Anmeldung für \(eventTitle) wirklich abschließen?")
                .font(.body)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Angemeldete Person:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(userName).bold()
                Text(userEmail)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            
            Spacer()
            
            // BARRIERE: Es gibt keinen sichtbaren "Abbrechen"- oder "Schließen"-Button. Nutzer können den Dialog nur abbrechen, indem sie das Sheet nach unten wischen, was für motorisch eingeschränkte Nutzer und blinde Nutzer ggf. nicht möglich ist
            Button(action: {
                onConfirm()
                isPresented = false
            }) {
                Text("Anmeldung verbindlich bestätigen")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    // BARRIERE: Keine Mindestgröße für Touch-Targets
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        // BARRIERE: Feste Höhe führt bei vergrößertem Text (Dynamic Type) zu Layout-Problemen und abgeschnittenen Inhalten
        .frame(height: 380)
        .background(Color(.systemBackground))
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
