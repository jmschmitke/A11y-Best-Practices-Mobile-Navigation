import SwiftUI

// Datenmodell für Events
struct CampusEvent: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let location: String
    let description: String
    let tag: String
    var isFavorite: Bool = false
}

struct EventView: View {
    
    // Testdaten
    @State private var events: [CampusEvent] = [
        CampusEvent(title: "Semester-Opening-Party", date: "15. Okt, 21:00 Uhr", location: "Campus Club", description: "Feiert mit uns den Start ins neue Semester! DJs, Drinks und gute Laune.", tag: "Party"),
        CampusEvent(title: "Karrieremesse 2026", date: "22. Okt, 10:00 Uhr", location: "Audimax Foyer", description: "Triff Top-Arbeitgeber aus der Region und knüpfe Kontakte für deinen Berufseinstieg.", tag: "Karriere"),
        CampusEvent(title: "Hochschulsport Fußballturnier", date: "05. Nov, 14:00 Uhr", location: "Sportplatz West", description: "Das jährliche Turnier der Fakultäten. Meldet eure Teams bis zum 01. Nov an.", tag: "Sport"),
        CampusEvent(title: "KI in der Praxis – Gastvortrag", date: "12. Nov, 17:00 Uhr", location: "Hörsaal 3", description: "Spannende Einblicke in aktuelle KI-Entwicklungen von Experten aus der Industrie.", tag: "Vortrag")
    ]
    
    // PATTERN 1: Status für die Textsuche
    @State private var searchText = ""
    
    // PATTERN 9: Status für Tag-Filter
    @State private var selectedTag: String = "Alle"
    let availableTags = ["Alle", "Party", "Karriere", "Sport", "Vortrag"]
    
    var filteredEvents: [CampusEvent] {
        events.filter { event in
            let matchesTag = (selectedTag == "Alle") || (event.tag == selectedTag)
            let matchesSearch = searchText.isEmpty ||
                                event.title.localizedCaseInsensitiveContains(searchText) ||
                                event.description.localizedCaseInsensitiveContains(searchText)
            return matchesTag && matchesSearch
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Text("Events")
                        .font(.headline)
                }
                
                // PATTERN 1: Suchleiste
                // BARRIERE: Keine semantische Gruppierung. VoiceOver liest Lupe, Textfeld und Löschen-Button als separate Elemente vor
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    // BARRIERE: Kein explizites Accessibility-Label
                    // BARRIERE: Falscher Tastatur-Typ
                    TextField("Events durchsuchen...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                    
                    if !searchText.isEmpty {
                        // BARRIERE: Touch-Target zu klein
                        // BARRIERE: onTapGesture statt Button. VoiceOver erkennt es nicht als klickbares Steuerelement
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                searchText = ""
                            }
                    }
                }
                .padding(8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding()
                
                // PATTERN 9: Filter
                VStack(alignment: .leading) {
                    Text("Filter:")
                        .font(.subheadline)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(availableTags, id: \.self) { tag in
                                HStack {
                                    // BARRIERE: Kein nativer Button/Toggle, für Tastatur/VoiceOver nicht erkennbar
                                    Image(systemName: selectedTag == tag ? "checkmark.square" : "square")
                                    
                                    Text(tag)
                                }
                                .font(.footnote) // BARRIERE: Zu kleine Schrift, bricht bei Skalierung
                                .onTapGesture {
                                    // BARRIERE: Löst Live-Filterung ohne Screenreader-Rückmeldung (AccessibilityNotification) aus
                                    selectedTag = tag
                                }
                                // BARRIERE: Kein Padding, Touch-Target zu klein
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom, 10)
                
                Divider()

                // PATTERN 5: Cards
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(filteredEvents) { event in
                            NavigationLink(destination: EventDetailView(event: event)) {
                                EventCardView(event: event) {
                                    toggleFavorite(for: event)
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private func toggleFavorite(for event: CampusEvent) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].isFavorite.toggle()
            // BARRIERE: Die VoiceOver-Ankündigung (AccessibilityNotification) wurde absichtlich weggelassen
        }
    }
}

// PATTERN 5: Event Card
struct EventCardView: View {
    let event: CampusEvent
    var onFavoriteToggle: () -> Void

    var body: some View {
        // BARRIERE: Ein ZStack/VStack-Konstrukt hat für Screenreader keine eindeutige Rolle. Ein Tastaturnutzer muss hier durch jedes einzelne Element (Tag, Text, Herz) tabben
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text(event.tag.uppercased())
                    .font(.caption)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.15))
                
                Spacer()
                
                // BARRIERE: onTapGesture auf einem Image statt einem echten Button
                // BARRIERE: Klickfläche zu klein
                // BARRIERE: Fehlendes Label
                Image(systemName: event.isFavorite ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(event.isFavorite ? .red : .gray)
                    .onTapGesture {
                        onFavoriteToggle()
                    }
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // BARRIERE: Titel ist nicht als Überschrift deklariert
                Text(event.title)
                    .font(.headline)
                
                HStack(spacing: 12) {
                    Text(event.date)
                    Text(event.location)
                }
                .font(.caption)
                .foregroundColor(.secondary)
                
                Text(event.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    // BARRIERE: Festes lineLimit in Kombination mit fester Card-Höhe bricht bei großen Schriften
                    .lineLimit(2)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        // BARRIERE: Feste Höhe führt bei Dynamic Type zum Layout-Kollaps und Abschneiden von Text
        .frame(height: 160)
        // BARRIERE: Zu wenig Kontrast
        .shadow(color: .gray.opacity(0.2), radius: 5)
    }
}

#Preview {
    EventView()
}
