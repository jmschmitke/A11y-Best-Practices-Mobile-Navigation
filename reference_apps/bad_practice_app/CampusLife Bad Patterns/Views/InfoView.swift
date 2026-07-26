import SwiftUI

// Sub-Tabs für den Info-Bereich
enum InfoTab: String, CaseIterable, Identifiable {
    case faq = "FAQ"
    case links = "Links"
    case contacts = "Kontakte"
    
    var id: String { self.rawValue }
}

struct InfoView: View {
    
    @State private var selectedTab: InfoTab = .faq

    var body: some View {
        VStack(spacing: 0) {
            
            // PATTERN 8: Nicht-nativer Header
            // BARRIERE: Ein einfacher Text anstelle von .navigationTitle(). VoiceOver erkennt dies nicht als Überschrift. Die feste Höhe schneidet den Text ab, wenn Nutzer in den iOS-Einstellungen die Schriftgröße (Dynamic Type) erhöhen.
            HStack {
                Text("Service & Info")
                    .font(.headline)
            }

            // PATTERN 4: Selbstgebaute Tabs ohne Semantik
            // BARRIERE: Ein einfaches HStack besitzt für Screenreader keine Gruppe/Rolle als "Tab-Leiste". Der native Picker wurde durch nicht-barrierefreie Buttons ersetzt.
            HStack(spacing: 0) {
                ForEach(InfoTab.allCases) { tab in
                    Button(action: { selectedTab = tab }) {
                        VStack {
                            Text(tab.rawValue)
                                .font(.body)
                                // BARRIERE: Zustand "ausgewählt" wird nur durch Farbe kommuniziert
                                .foregroundColor(selectedTab == tab ? .blue : .gray)
                        }
                        .frame(maxWidth: .infinity)
                        // BARRIERE: Fehlendes vertikales Padding. Die Klickfläche ist zu klein
                    }
                }
            }
            .frame(height: 40) // BARRIERE: Feste Höhe führt bei großer Systemschrift zum Abschneiden des Textes
            
            Divider()
            
            // PATTERN 8: Fehlende ScrollView & Abgeschnittener Inhalt
            // BARRIERE: Keine ScrollView. Große Texte oder kleine Bildschirme führen dazu, dass Inhalte unten abgeschnitten werden
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
            
            Spacer()
        }
        // BARRIERE: Starr erzwungene Orientierung (Pattern 8)
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}

// Tab 1: FAQ Content
struct FaqContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // BARRIERE: Keine explizite Überschriften-Rolle (.isHeader). Screenreader-Nutzer können nicht via Rotor direkt zu dieser Überschrift springen.
            Text("Häufig gestellte Fragen (FAQ)")
                .font(.title2)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 12) {
                // BARRIERE: Kein .isHeader
                Text("Wie erhalte ich meinen Bibliotheksausweis?")
                    .font(.headline)
                
                Text("Ihr Studierendenausweis gilt automatisch als Bibliotheksausweis. Sie müssen ihn lediglich bei der ersten Nutzung an der Information aktivieren lassen.")
                    .font(.body)
                    // BARRIERE: Geringer Kontrast
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 12) {
                Text("Wo finde ich meinen Semesterdeckbeitrag?")
                    .font(.headline)
                
                Text("Die Kontodaten und der Überweisungszweck für die Rückmeldung stehen im Online-Portal unter dem Menüpunkt 'Studienverwaltung'.")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

//Tab 2: Links Content
struct LinksContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Wichtige Portale & Links")
                .font(.title2)
                .fontWeight(.bold)
                // BARRIERE: Kein .isHeader

            VStack(spacing: 20) {
                // Link 1
                Button(action: { /* Hier wird der Link eingefügt */ }) {
                    HStack {
                        Image(systemName: "arrow.up.right.square")
                        Text("Prüfungsamt Portal")
                        Spacer()
                    }
                    // BARRIERE: Kein Padding und keine Mindesthöhe. Die Klickfläche beschränkt sich auf den reinen Text und ist zu klein
                    // BARRIERE: Keine .accessibilityLabel oder .accessibilityHint für Screenreader
                }

                // Link 2
                Button(action: { /* Hier wird der Link eingefügt */ }) {
                    HStack {
                        Image(systemName: "fork.knife")
                        Text("Mensa Speiseplan")
                        Spacer()
                    }
                }
            }
            .padding(.top, 10)
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
                // BARRIERE: .isHeader fehlt

            VStack(alignment: .leading, spacing: 8) {
                Text("Studierendensekretariat")
                    .font(.headline)
                
                Text("E-Mail: service@hochschule.de")
                    .font(.body)
                
                Text("Sprechzeiten: Mo–Do 09:00–12:00 Uhr")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
        }
    }
}

#Preview {
    InfoView()
}
