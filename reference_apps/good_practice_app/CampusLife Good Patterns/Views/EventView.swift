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
    
    // Testdaten für die Events
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
    
    // Gefilterte Events basierend auf Suche und Tag
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
            NavigationStack {
                VStack(spacing: 0) {
                    // Ausgelagerte Filter-Leiste
                    FilterBarView(
                        availableTags: availableTags,
                        selectedTag: selectedTag,
                        onSelectTag: applyFilter
                    )
                    
                    Divider()

                    // Ausgelagerte Event-Liste
                    EventListView(
                        events: filteredEvents,
                        onFavoriteToggle: toggleFavorite
                    )
                }
                .navigationTitle("Event-Kalender")
                .searchable(text: $searchText, prompt: "Events durchsuchen...")
            }
        }
    
    // Hilfsfunktion zur Filter-Anwendung mit Screenreader-Feedback (Pattern 9)
    private func applyFilter(_ tag: String) {
        selectedTag = tag
        
        // Teilt dem Screenreader die Aktualisierung dynamisch mit
        let count = filteredEvents.count
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            AccessibilityNotification.Announcement("Filter auf \(tag) geändert. \(count) \(count == 1 ? "Event" : "Events") verfügbar.")
                .post()
        }
    }
    
    // Umschalten des Favoriten-Status
    private func toggleFavorite(for event: CampusEvent) {
        if let index = events.firstIndex(where: { $0.id == event.id }) {
            events[index].isFavorite.toggle()
            
            let status = events[index].isFavorite ? "zu Favoriten hinzugefügt" : "aus Favoriten entfernt"
            AccessibilityNotification.Announcement("\(event.title) \(status)")
                .post()
        }
    }
}

// PATTERN 5: Einzelne Event-Card Komponente
struct EventCardView: View {
    let event: CampusEvent
    var onFavoriteToggle: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Header-Zeile mit Tag und Favoriten-Button
            HStack {
                Text(event.tag.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Color.accentColor.opacity(0.15))
                    .foregroundStyle(Color.accentColor)
                    .clipShape(Capsule())
                
                Spacer()
                
                // Favoriten-Button mit Touch-Target (Pattern 5)
                Button(action: onFavoriteToggle) {
                    Image(systemName: event.isFavorite ? "heart.fill" : "heart")
                        .font(.title3)
                        .foregroundStyle(event.isFavorite ? .red : .gray)
                        .frame(width: 44, height: 44) //Mindestzielgröße
                }
                .buttonStyle(.borderless)
                .accessibilityLabel(event.isFavorite ? "Aus Favoriten entfernen" : "Zu Favoriten hinzufügen")
            }
            
            // Hauptinhalt der Card
            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                    .accessibilityAddTraits(.isHeader) // Überschrift für Rotor
                
                HStack(spacing: 12) {
                    Label(event.date, systemImage: "calendar")
                    Label(event.location, systemImage: "mappin.and.ellipse")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                Text(event.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .padding(.top, 2)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        // Visueller Kontrastrand für die Card-Ablösung
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
    }
}

struct FilterBarView: View {
    let availableTags: [String]
    let selectedTag: String
    let onSelectTag: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(availableTags, id: \.self) { tag in
                        FilterChipButton(
                            tag: tag,
                            isSelected: selectedTag == tag,
                            action: { onSelectTag(tag) }
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
        }
        .background(Color(.systemBackground))
    }
}

struct FilterChipButton: View {
    let tag: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(tag)
                .font(.subheadline)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.accentColor : Color(.secondarySystemBackground))
                .foregroundStyle(isSelected ? .white : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.clear : Color(.systemGray4), lineWidth: 1)
                )
        }
        .frame(minHeight: 44) //Mindest-Touch-Target
        .accessibilityLabel("Filter \(tag)")
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

struct EventListView: View {
    let events: [CampusEvent]
    let onFavoriteToggle: (CampusEvent) -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                if events.isEmpty {
                    ContentUnavailableView(
                        "Keine Events gefunden",
                        systemImage: "calendar.badge.exclamationmark",
                        description: Text("Versuche einen anderen Suchbegriff oder Filter.")
                    )
                    .padding(.top, 40)
                } else {
                    ForEach(events) { event in
                        NavigationLink(destination: EventDetailView(event: event)) {
                            EventCardView(
                                event: event,
                                onFavoriteToggle: { onFavoriteToggle(event) }
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    EventView()
}
