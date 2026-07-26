import SwiftUI

// Datenmodell für Campus-News
struct NewsCardItem: Identifiable {
    let id = UUID()
    let title: String
    let category: String
    let color: Color
}

struct NewsView: View {
    
    // Testdaten
    let newsItems: [NewsCardItem] = [
        NewsCardItem(title: "Willkommen zum neuen Semester 2026!", category: "Campus News", color: .red),
        NewsCardItem(title: "Großes Sommerfest auf der Campuswiese", category: "Event", color: .red),
        NewsCardItem(title: "Neue Öffnungszeiten der Universitätsbibliothek", category: "Service", color: .red)
    ]
    
    @State private var currentIndex = 0
    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // PATTERN 2: Nicht nativer Navigationstitel / Header
                // BARRIERE: Ein gewöhnlicher Standard-Text anstelle von .navigationTitle()
                // 1. VoiceOver liest diesen Text nur als normalen Fließtext und nicht als Überschrift
                // 2. Feste Höhe und lineLimit(1) führen bei Dynamic Type zum Abschneiden des Textes
                HStack {
                    Spacer()
                    Text("News-Feed")
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                }
                .frame(height: 44)
                .background(Color(.systemBackground))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // PATTERN 6: Karussell
                        VStack(spacing: 12) {
                            
                            // BARRIERE: Manuell gebautes Karussell über DragGesture anstelle einer nativen TabView
                            GeometryReader { geometry in
                                let cardWidth: CGFloat = 300
                                let spacing: CGFloat = 16
                                let totalOffset = -CGFloat(currentIndex) * (cardWidth + spacing) + dragOffset
                                
                                HStack(spacing: spacing) {
                                    ForEach(newsItems.indices, id: \.self) { index in
                                        let item = newsItems[index]
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            // BARRIERE: Schlechter Farbkontrast
                                            Text(item.category.uppercased())
                                                .font(.caption)
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.black.opacity(0.4))
                                            
                                            Text(item.title)
                                                .font(.title3)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.leading)
                                            
                                            Spacer()
                                        }
                                        .padding(20)
                                        // BARRIERE: Feste Breite & Höhe. Schneidet den Text bei Dynamic Type ab
                                        .frame(width: cardWidth, height: 170, alignment: .leading)
                                        .background(item.color)
                                        .cornerRadius(16)
                                    }
                                }
                                .offset(x: totalOffset)
                                .padding(.horizontal, max(0, (geometry.size.width - cardWidth) / 2))
                                .gesture(
                                    DragGesture()
                                        .updating($dragOffset) { value, state, _ in
                                            state = value.translation.width
                                        }
                                        .onEnded { value in
                                            let threshold: CGFloat = 50
                                            if value.translation.width < -threshold {
                                                currentIndex = min(currentIndex + 1, newsItems.count - 1)
                                            } else if value.translation.width > threshold {
                                                currentIndex = max(currentIndex - 1, 0)
                                            }
                                        }
                                )
                                .animation(.easeInOut(duration: 0.25), value: currentIndex)
                                .animation(.linear(duration: 0.1), value: dragOffset)
                            }
                            .frame(height: 170)
                            
                            // BARRIERE: Zu kleine Touch-Targets
                            HStack(spacing: 12) {
                                ForEach(newsItems.indices, id: \.self) { index in
                                    Circle()
                                        .fill(currentIndex == index ? Color.black : Color.gray)
                                        .frame(width: 8, height: 8)
                                        .onTapGesture {
                                            currentIndex = index
                                        }
                                }
                            }
                            .padding(.top, 4)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // Weitere Inhalte des News-Feeds
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Aktuelle Mitteilungen")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            // BARRIERE: Zu schwacher Farbkontrast
                            Text("Willkommen auf dem digitalen Campus der Hochschule. Hier finden Sie alle aktuellen Informationen rund um Studium, Events und Services.")
                                .font(.body)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            // BARRIERE: Nativer Navigationstitel explizit weggelassen
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    NewsView()
}
