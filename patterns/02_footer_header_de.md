# 02: Footer & Header

Ausgewählte Sprache: Deutsch

Andere Sprachen: tbd

---

<details>
  <summary><b>Inhaltsverzeichnis Pattern</b> (Klicken zum Ausklappen)</summary>
  <br>

  * [Search](01_search_de.md)
  * Footer & Header <b>(Aktuell ausgewählt)</b>
  * [Modal (Popup)](03_modal_popup_de.md)
  * [Tabs](04_tabs.md)
  * [Cards](05_cards.md)

</details>

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Header und Footer bilden den strukturellen Rahmen einer App. Der Header dient meist der Orientierung (Anzeige des aktuellen Screen-Namens, Zurück-Button, Profil- oder Einstellungs-Icons). Der Footer verankert die primären Navigationsziele der App auf der obersten Ebene oder bietet kontextuelle Aktionen am unteren Bildschirmrand. Da diese Elemente permanent sichtbar sind, müssen sie maximale Konsistenz und fehlerfreie Zugänglichkeit garantieren.

### Typische Barrieren in der Praxis
* **Layout-Bruch bei Textvergrößerung**: Wenn Nutzende die Systemschriftgröße (Dynamic Type) stark erhöhen, kollidieren statisch programmierte Titel und Icons im Header. Text wird unleserlich abgeschnitten oder Steuerelemente überlagern sich, wodurch wichtige Funktionen unbedienbar werden.
* **Kognitive Hürden durch reine Icon-Navigation**: Aus Platzgründen wird im Footer oft auf Text-Labels unter den Navigations-Symbolen verzichtet. Für blinde, sehbehinderte oder kognitiv eingeschränkte Menschen sind abstrakte Symbole ohne eindeutige Textbeschreibung jedoch kaum fehlerfrei zu interpretieren.
* **Unerreichbare Touch-Targets an den Bildschirmrändern**: Da Header ganz oben und Footer ganz unten platziert sind, rutschen interaktive Buttons gefährlich nah an die physischen Displayränder. Ohne eine großzügige, unsichtbare Klickfläche von mindestens 44x44pt sind sie motorisch extrem schwer zu treffen.
* **Unlogische Fokus-Reihenfolge und Navigationsfallen**: Wenn Inhaltsbereiche scrollbar sind, verlieren Apps oft die Kontrolle über den linearen Lesefluss von Screenreadern. Nutzende geraten beim Wischen in Endlosschleifen innerhalb des Hauptinhalts und können den Footer oder die Tab-Bar überhaupt nicht mehr erreichen.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.


| Barrierefreiheits-Anforderung | WCAG 2.2 Kriterium | EN 301 549 | Relevanz für das Header/Footer-Pattern |
| :--- | :--- | :--- | :--- |
| **Informationen & Beziehungen** | 1.3.1 Info and Relationships | 11.1.3.1 | Programmatische Kennzeichnung von Kopf- und Fußzeilen als strukturelle Container. |
| **Bedeutungsvolle Reihenfolge** | 1.3.2 Meaningful Sequence | 11.1.3.2 | Logischer, linearer Lesefluss (Header -> Hauptinhalt -> Footer) ohne Navigationsfallen. |
| **Kontrast (Minimum)** | 1.4.3 Contrast (Minimum) | 11.1.4.3 | Texte, Icons und visuelle Trennlinien (Separators) müssen sich scharf vom Hintergrund abheben. |
| **Text vergrößern** | 1.4.4 Resize Text | 11.1.4.4 | Leisten müssen mit skalierenden Texten (Dynamic Type) wachsen, ohne Inhalt abzuschneiden. |
| **Tastatur-Bedienbarkeit** | 2.1.1 Keyboard | 11.2.1.1 | Volle Erreichbarkeit und Bedienbarkeit der Tabs und Header-Buttons per externer Tastatur. |
| **Fokus-Reihenfolge** | 2.4.3 Focus Order | 11.2.4.3 | Der Fokuspfad darf nicht in scrollbaren Inhalten gefangen sein, sondern muss den Footer erreichen. |
| **Fokus sichtbar** | 2.4.7 Focus Visible | 11.2.4.7 | Deutlicher visueller Fokusrahmen um ausgewählte Tabs oder Header-Aktionen bei Tastaturnavigation. |
| **Zielgröße (Minimum)** | 2.5.8 Target Size (Min) | 11.2.5.8 | Jedes Icon an den kritischen Bildschirmrändern benötigt eine Klickfläche von mind. 44x44pt. |
| **Bei Fokus** | 3.2.1 On Focus | 11.3.2.1 | Das bloße Ansteuern eines Tabs via Screenreader darf noch keinen automatischen Screen-Wechsel auslösen. |
| **Konsistente Navigation** | 3.2.3 Consistent Navigation | - | Die Anordnung und Position des Footers muss auf jeder Hierarchieebene der App identisch bleiben. |
| **Konsistente Identifikation** | 3.2.4 Consistent Identification | - | Systemweite Symbole (z. B. Profil, Home) müssen auf jedem Screen denselben Namen tragen. |
| **Name, Rolle, Wert** | 4.1.2 Name, Role, Value | 11.4.1.2 | Eindeutige Zuteilung der Rolle „Tab“ und korrekte Meldung des Status („ausgewählt“ vs. „nicht ausgewählt“). |
| **Assistive Technologien** | - | 11.5.2.4 / 11.5.2.5 | Korrekte Übermittlung der Leisten- und Containertypen an die native Accessibility-API des OS. |

---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* **Dynamic Type Support**: Header und Footer dürfen keine feste, statische Höhe in pt besitzen. Sie müssen dynamisch mitwachsen, wenn Nutzende die Systemschriftgröße ändern. Text-Labels in der TabBar dürfen bei maximaler Vergrößerung zweizeilig werden oder in ein vertikales Stack-Layout wechseln.
* **Zwingende Text-Kombination**: Jedes Icon im Footer muss von einem permanenten, gut lesbaren Text-Label begleitet werden. Reine Icon-Navigation ist unzulässig.
* **Kontrastlinien**: Da Header und Footer oft farblich mit dem Hauptinhalt verschmelzen, ist eine visuelle Trennlinie (Separator) mit einem Kontrast von mindestens 3:1 zum Hintergrund zwingend erforderlich, um die strukturellen Zonen der App kognitiv klar abzugrenzen.

### Interaktionsdesign und Touch-Targets
* **Safe Area Einbettung**: Elemente im Header und Footer müssen strikt innerhalb der vom System vorgegebenen Safe Area liegen, um Überlagerungen mit der Statusleiste (oben) oder dem Home-Indicator (unten) zu verhindern.
* **Touch-Flächen**: Jedes interaktive Element (z. B. der „Edit“-Button im Header oder ein Tab im Footer) muss eine physische Touch-Fläche von mindestens 44 x 44 pt garantieren. Bei 4-5 Tabs im Footer teilt sich die Breite meist automatisch auf, die Höhe muss jedoch strikt eingehalten werden.

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
1. **Fokus 1:** Der Header-Titel (deklariert als Überschrift / Heading). VoiceOver liest: „[Titel], Überschrift“.*
2. **Fokus 2 (Bedingt):** Optionale Funktionstasten im Header (links/rechts) von links nach rechts geordnet.*
3. **Fokus 3:** Der Hauptinhalt (Main Content) des Screens.*
3. **Fokus 4:** Die Tab-Bar im Footer. Beim Wechsel auf ein Element liest VoiceOver: „Home, Tab, 1 von 4, ausgewählt“. Der ausgewählte Zustand ist elementar!

## 4. Implementierung (SwiftUI)

### Good Pattern (Positivbeispiel)
Dieses Beispiel zeigt eine empfohlene, barrierefreie Implementierung eines Footers und Headders, welche native Komponenten nach den Apple Human Interface Guidelines verwendet.
```swift
import SwiftUI

struct GoodHeaderFooterView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        // Native TabView für die korrekte Rolle
        TabView(selection: $selectedTab) {
            
            // Hauptbereich mit integriertem Header
            NavigationStack {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(1...30, id: \.self) { index in
                            Text("Transaktion #\(index)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(.secondarySystemBackground))
                        }
                    }
                    .padding()
                }
                // Die native NavigationBar wächst bei Dynamic Type automatisch mit und bricht den Text barrierefrei in die nächste Zeile um.
                .navigationTitle("Kontodetails")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // Links: Zurück-Button
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { /* Zurück-Aktion */ }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .bold()
                                Text("Zurück")
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .padding(.vertical, 11)
                            .padding(.horizontal, 8)
                            // Dieser unsichtbare Hintergrund stellt sicher dass die Klickfläche IMMER mindestens 44x44pt groß ist, selbst wenn der Inhalt kleiner wäre.
                            .background(
                                Color.clear
                                    .frame(minWidth: 44, minHeight: 44)
                            )
                        }
                    }
                    
                    // Rechts: Einstellungs-Button
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { /* Einstellungen-Aktion */ }) {
                            Image(systemName: "gearshape.fill")
                                .padding(11)
                                .background(
                                    Color.clear
                                        .frame(minWidth: 44, minHeight: 44)
                                )
                        }
                        // Eindeutiger barrierefreier Name für Screenreader
                        .accessibilityLabel("Einstellungen öffnen")
                    }
                }
            }
            // Text-Icon-Kombination im Footer.
            // Das System meldet Zustand ("ausgewählt") und Index ("1 von 2") automatisch an VoiceOver.
            .tabItem {
                Image(systemName: "house.fill")
                Text("Übersicht")
            }
            .tag(0)
            
            // ZWEITER TAB
            Text("Karten-Ansicht")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Karten")
                }
                .tag(1)
        }
        // Visuelle Kontrastlinie (Separator) zum Hauptinhalt.
        // Native System-TabBars bringen diese Trennung mit ausreichendem Kontrast bereits mit.
        .accentColor(.blue) // Markiert den aktiven Tab für die Barrierefreiheit deutlich
    }
}
```

### Bad Pattern (Negativbeispiel)
Dieses Beispiel zeigt eine typisch fehlerhafte Implementierung eines Footers und Headers. Sie ignoriert zentrale Vorgaben bezüglich Höhe von Buttons, nativer Implementierung der Syntax sowie Fokus-Management des Screenreaders.
```swift
import SwiftUI

struct BadHeaderFooterView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // --- CUSTOM HEADER ---
            // BARRIERE 1: Feste Höhe von 55pt. Wenn "Dynamic Type" den Text vergrößert, bricht das Layout.
            HStack {
                // BARRIERE 2: Kein nativer Button, sondern nur ein Image mit Geste.
                // Es gibt kein visuelles oder auditives Feedback für Screenreader.
                Image(systemName: "chevron.left")
                    .font(.body)
                    .frame(width: 20, height: 20) // Touch-Target viel zu klein (< 44x44pt)!
                    .onTapGesture { /* Zurück-Aktion */ }
                
                Spacer()
                
                // BARRIERE 3: Text ist nicht als Überschrift (Heading) deklariert.
                // Ein Screenreader erkennt die strukturelle Hierarchie nicht.
                Text("Kontodetails und Einstellungen")
                    .font(.headline)
                    .lineLimit(1) // Schneidet Text gnadenlos mit "..." ab
                
                Spacer()
                
                Image(systemName: "gearshape")
                    .frame(width: 20, height: 20)
                    .onTapGesture { /* Einstellungen-Aktion */ }
            }
            .padding(.horizontal)
            .frame(height: 55) 
            .background(Color(.systemBackground))
            
            // --- HAUPTINHALT ---
            // BARRIERE 4: Eine unendliche ScrollView ohne Fokus-Management.
            // VoiceOver-Nutzer können sich in den Daten verlieren und erreichen den Footer schwer.
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(1...30, id: \.self) { index in
                        Text("Transaktion #\(index)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color(.secondarySystemBackground))
                    }
                }
                .padding()
            }
            
            // --- CUSTOM FOOTER ---
            // BARRIERE 5: Reine Icon-Navigation ohne Text-Labels.
            HStack {
                Spacer()
                Image(systemName: "house.fill")
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    .onTapGesture { selectedTab = 0 }
                Spacer()
                Image(systemName: "creditcard.fill")
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    .onTapGesture { selectedTab = 1 }
                Spacer()
            }
            .frame(height: 50) // Kollidiert mit dem Home-Indicator (keine Safe Area)!
            .background(Color(.systemBackground))
        }
    }
}
```
