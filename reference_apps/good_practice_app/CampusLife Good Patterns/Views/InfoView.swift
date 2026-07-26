import SwiftUI

// Sub-Tabs für den Info-Bereich (Pattern 4)
enum ServiceTab: String, CaseIterable, Identifiable {
    case faq = "FAQ"
    case links = "Links"
    case contacts = "Kontakte"
    
    var id: String { self.rawValue }
}

struct InfoView: View {
    
    // Status für den aktuell ausgewählten Unter-Tab (Pattern 4)
    @State private var selectedTab: ServiceTab = .faq

    var body: some View {
        // PATTERN 8: Nativer NavigationStack regelt Struktur, Titel & Fokus
        NavigationStack {
            VStack(spacing: 0) {
                
                // PATTERN 4: Tabs (Sub-Navigation via Picker)
                Picker("Service-Kategorie auswählen", selection: $selectedTab) {
                    ForEach(ServiceTab.allCases) { tab in
                        Text(tab.rawValue).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                // VoiceOver meldet automatisch Rolle ("Registerkarte") und Zustand ("ausgewählt")
                .accessibilityLabel("Service-Bereich wechseln")
                .accessibilityHint("Wählen Sie zwischen FAQ, nützlichen Links und Ansprechpartnern.")

                // PATTERN 8: Navigationsstruktur & Layout bei Text-Inhalten
                // ScrollView ist essenziell für Reflow, verhindert Abschneiden von Text selbst bei großer Schriftgröße.
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        switch selectedTab {
                        case .faq:
                            FaqContentView()
                        case .links:
                            LinksContentView()
                        case .contacts:
                            ContactsContentView()
                        }
                    }
                    .padding()
                }
            }
            // Eindeutiger, programmatischer Seitentitel
            .navigationTitle("Service & Info")
        }
    }
}

// Tab 1: FAQ Content
struct FaqContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // Überschrift 1 (Header-Trait für Screen-Reader-Rotor)
            Text("Häufig gestellte Fragen (FAQ)")
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)
            
            VStack(alignment: .leading, spacing: 12) {
                // Frage 1
                Text("Wie erhalte ich meinen Bibliotheksausweis?")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Ihr Studierendenausweis gilt automatisch als Bibliotheksausweis. Sie müssen ihn lediglich bei der ersten Nutzung an der Information aktivieren lassen.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 12) {
                // Frage 2
                Text("Wo finde ich meinen Semesterdeckbeitrag?")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Die Kontodaten und der Überweisungszweck für die Rückmeldung stehen im Online-Portal unter dem Menüpunkt 'Studienverwaltung'.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

// Tab 2: Links Content
struct LinksContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Wichtige Portale & Links")
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)

            VStack(spacing: 12) {
                // Link 1
                Button(action: { /* Hier würde Link hinterlegt werden */ }) {
                    HStack {
                        Image(systemName: "arrow.up.right.square")
                            .font(.title3)
                        Text("Prüfungsamt Portal")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    // Touch-Target weit über der 44x44pt Mindestgröße
                    .frame(minHeight: 50)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .accessibilityLabel("Prüfungsamt Portal")
                .accessibilityHint("Öffnet das Prüfungsportal im Browser.")

                // Link 2
                Button(action: { /* Hier würde Link hinterlegt werden */ }) {
                    HStack {
                        Image(systemName: "fork.knife")
                            .font(.title3)
                        Text("Mensa Speiseplan")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .frame(minHeight: 50)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .accessibilityLabel("Mensa Speiseplan")
                .accessibilityHint("Öffnet den aktuellen Speiseplan.")
            }
        }
    }
}

// Tab 3: Contacts Content
struct ContactsContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Zentrale Ansprechpartner")
                .font(.title2)
                .fontWeight(.bold)
                .accessibilityAddTraits(.isHeader)

            VStack(alignment: .leading, spacing: 8) {
                Text("Studierendensekretariat")
                    .font(.headline)
                    .accessibilityAddTraits(.isHeader)
                
                Text("E-Mail: service@hochschule.de")
                    .font(.body)
                
                Text("Sprechzeiten: Mo–Do 09:00–12:00 Uhr")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    InfoView()
}
