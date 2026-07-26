import SwiftUI

// Datenmodell für News Cards
struct NewsCardItem: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let color: Color
}

struct NewsView: View {
    
    // Testdaten
    let newsItems: [NewsCardItem] = [
        NewsCardItem(title: "Willkommen zum neuen Semester 2026!", category: "Campus News", color: .blue),
        NewsCardItem(title: "Großes Sommerfest auf der Campuswiese", category: "Event", color: .indigo),
        NewsCardItem(title: "Neue Öffnungszeiten der Universitätsbibliothek", category: "Service", color: .teal)
    ]
    
    // Status für das aktuell ausgewählte Element im Karussell
    @State private var currentIndex = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // PATTERN 6 (Karussell) & PATTERN 7 (Gesten-Alternative)
                    VStack(spacing: 12) {
                        
                        // Native TabView (Gestütztes Wischen für VoiceOver)
                        TabView(selection: $currentIndex) {
                            ForEach(newsItems.indices, id: \.self) { index in
                                let item = newsItems[index]
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(item.category.uppercased())
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white.opacity(0.85))
                                    
                                    Text(item.title)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                        .multilineTextAlignment(.leading)
                                    
                                    Spacer()
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(item.color)
                                )
                                .tag(index)
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        .frame(height: 170)
                        
                        // Präzise Zusammenfassung für den Screen Reader
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("Highlight-Thema \(currentIndex + 1) von \(newsItems.count): Kategorie \(newsItems[currentIndex].category), \(newsItems[currentIndex].title)")
                        .accessibilityHint("Nutzen Sie die Steuerungstasten unten, um die Folie zu wechseln.")
                        
                        // PATTERN 7: Alternative Steuerungselemente (Tasten statt reiner Wischgeste)
                        HStack {
                            Text("Highlight \(currentIndex + 1) von \(newsItems.count)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                // Button ZURÜCK
                                Button(action: {
                                    if currentIndex > 0 {
                                        withAnimation { currentIndex -= 1 }
                                    }
                                }) {
                                    Image(systemName: "chevron.left")
                                        .font(.body.weight(.bold))
                                        .foregroundStyle(currentIndex == 0 ? .tertiary : .primary)
                                        // Garantiert mindestens 44x44 pt Klickfläche
                                        .frame(width: 44, height: 44)
                                        .background(Color(.secondarySystemBackground))
                                        .clipShape(Circle())
                                }
                                .accessibilityLabel("Vorheriges Highlight anzeigen")
                                .disabled(currentIndex == 0)
                                
                                // Button VOR
                                Button(action: {
                                    if currentIndex < newsItems.count - 1 {
                                        withAnimation { currentIndex += 1 }
                                    }
                                }) {
                                    Image(systemName: "chevron.right")
                                        .font(.body.weight(.bold))
                                        .foregroundStyle(currentIndex == newsItems.count - 1 ? .tertiary : .primary)
                                        // Garantiert mindestens 44x44 pt Klickfläche
                                        .frame(width: 44, height: 44)
                                        .background(Color(.secondarySystemBackground))
                                        .clipShape(Circle())
                                }
                                .accessibilityLabel("Nächstes Highlight anzeigen")
                                .disabled(currentIndex == newsItems.count - 1)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical, 8)
                    
                    // Aktuelle Mitteilungen
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Aktuelle Mitteilungen")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Willkommen auf dem digitalen Campus der Hochschule. Hier finden Sie alle aktuellen Informationen rund um Studium, Events und Services.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            // Programmatischer Seitentitel
            .navigationTitle("News-Feed")
        }
    }
}

#Preview {
    NewsView()
}

