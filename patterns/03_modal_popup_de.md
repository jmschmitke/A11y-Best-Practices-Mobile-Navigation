# 03: Popup

Ausgewählte Sprache: Deutsch

Andere Sprachen: tbd

---

<details>
  <summary><b>Inhaltsverzeichnis Pattern</b> (Klicken zum Ausklappen)</summary>
  <br>

  * [Search](01_search_de.md)
  * [Footer & Header](02_footer_header_de.md)
  * Modal (Popup) <b>(Aktuell ausgewählt)</b>
  * [Tabs](04_tabs.md)
  * [Cards](05_cards.md)

</details>

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Popups – oft auch als Modals, Bottom Sheets oder Dialogfenster bezeichnet – unterbrechen den regulären App-Flow, um die ungeteilte Aufmerksamkeit der Nutzenden auf eine kritische Aktion oder Information zu lenken.
Sie werden häufig für Bestätigungen (z.B. Löschvorgänge), Dateneingaben (z.B. "Neuen Eintrag erstellen") oder wichtige Systemmeldungen genutzt. Da sie sich visuell über den bestehenden Inhalt legen, stellen sie eine massive Veränderung des Kontexts dar und müssen für assistive Technologien absolut unmissverständlich umgesetzt sein.

### Typische Barrieren in der Praxis
* **Die Screenreader-Falle (Focus Trapping Missing)**: Wenn sich ein Popup öffnet, verbleibt der unsichtbare Fokus von Screenreadern (VoiceOver) oft im darunterliegenden Hauptinhalt. Blinde Nutzende "verirren" sich dann in Elementen, die visuell gar nicht mehr sichtbar oder interaktiv sind, und bemerken das geöffnete Popup überhaupt nicht.
* **Fehlende oder unklare Schließoptionen**: Popups werden oft so gestaltet, dass man sie durch Tippen auf den abgedunkelten Hintergrund schließt. Ohne einen expliziten, barrierefreien "Schließen"-Button (oder ein "X") sind Tastaturnutzende oder Menschen mit motorischen oder kognitiven Einschränkungen in dem Dialog gefangen.
* **Layout-Kollaps bei Dynamic Type**: Da Popups konstruktionsbedingt weniger Platz als der Vollbildmodus haben, führt eine Erhöhung der Systemschriftgröße schnell dazu, dass Text aus dem sichtbaren Bereich geschoben wird oder die "Abbrechen"- und "Bestätigen"-Buttons den Text gegenseitig überlagern und unlesbar machen.
* **Unerwarteter Kontextwechsel ohne Ankündigung**: Wenn Popups automatisch und ohne direkte Nutzerinteraktion aufpoppen (z.B. Cookie-Banner, In-App-Werbung oder plötzliche Systemhinweise), desorientiert dies Menschen mit kognitiven Einschränkungen oder Screenreader-Nutzende massiv, wenn der aktuelle Fokus abrupt zerrissen wird.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.

| Barrierefreiheits-Anforderung | WCAG 2.2 Kriterium | EN 301 549 | Relevanz für das Popup-Pattern |
| :--- | :--- | :--- | :--- |
| **Informationen & Beziehungen** | 1.3.1 Info and Relationships | 11.1.3.1 | Das Popup muss als eigenständiger, abgegrenzter Container strukturiert sein. |
| **Bedeutungsvolle Reihenfolge** | 1.3.2 Meaningful Sequence | 11.1.3.2 | Der Lesefluss muss zwingend innerhalb des Popups bleiben und darf nicht nach hinten ausbrechen. |
| **Kontrast (Minimum)** | 1.4.3 Contrast (Minimum) | 11.1.4.3 | Der Dialog-Hintergrund muss sich scharf vom darunterliegenden (abgedunkelten) Inhalt abheben. |
| **Text vergrößern** | 1.4.4 Resize Text | 11.1.4.4 | Der Inhalt im Popup muss scrollbar sein, falls Text durch Dynamic Type nicht mehr auf den Screen passt. |
| **Tastatur-Bedienbarkeit** | 2.1.1 Keyboard | 11.2.1.1 | Das Popup muss komplett per Tastatur (z.B. Schließen via `Esc`-Taste) bedienbar sein. |
| **Keine Tastatur-Falle** | 2.1.2 No Keyboard Trap | 11.2.1.2 | Der Fokus darf das Popup erst verlassen, wenn es explizit geschlossen wurde (Focus Trap). |
| **Fokus-Reihenfolge** | 2.4.3 Focus Order | 11.2.4.3 | Beim Öffnen MUSS der Fokus direkt auf das erste Element im Popup springen (nicht im Hintergrund verharren). |
| **Fokus sichtbar** | 2.4.7 Focus Visible | 11.2.4.7 | Interaktive Elemente im Popup (Buttons, Felder) benötigen einen deutlich sichtbaren Fokusrahmen. |
| **Zielgröße (Minimum)** | 2.5.8 Target Size (Min) | 11.2.5.8 | Der Schließen-Button ("X") und alle Aktions-Buttons benötigen eine Klickfläche von mind. 44x44pt. |
| **Name, Rolle, Wert** | 4.1.2 Name, Role, Value | 11.4.1.2 | Das Element muss die Rolle „Dialog“ oder „Popup“ besitzen; Zustand („geöffnet“) muss klar sein. |
| **Assistive Technologien** | - | 11.5.2.4 / 11.5.2.5 | Der Hintergrund muss für die Accessibility-API temporär als "unsichtbar" deklariert werden. |

---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* **Dynamic Type & Scrollbarkeit**: Popups dürfen niemals eine feste vertikale Größe besitzen, die den Inhalt beschränkt. Sobald der Text durch die Systemschriftgröße wächst, muss der Inhaltsbereich des Popups automatisch in eine ScrollView übergehen, damit alle Texte und Buttons erreichbar bleiben.
* **Hintergrund-Dimmer**: Um den Kontextwechsel visuell zu signalisieren, muss der Hintergrund hinter dem Popup abgedunkelt werden (Overlay-Kontrast). 
* **Expliziter Schließen-Button**: Jedes Popup benötigt oben rechts oder oben links einen klar erkennbaren Button zum Schließen (Text "Schließen" oder ein valides Schließen-Icon). Ein Schließen *nur* durch Tippen außerhalb des Modals ist unzulässig.

### Interaktionsdesign und Touch-Targets
* **Fokus-Falle**: Solange das Popup geöffnet ist, ist der Hintergrund blockiert. Wisch-Gesten des Screenreaders oder Tab-Sprünge der Tastatur dürfen sich ausschließlich im Kreis innerhalb des Popups bewegen.
* **Touch-Flächen**: Buttons wie "Abbrechen", "Speichern" oder das Schließen-Kreuz müssen eine physische Touch-Fläche von mindestens 44 x 44 pt aufweisen. 

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
* **Fokus 1 (Titel):** Der Popup-Titel (deklariert als Überschrift). VoiceOver liest sofort beim Öffnen: „[Titel des Popups], Überschrift“. Das signalisiert Orientierung.
* **Fokus 2 (Inhalt):** Der Inhalts-Text oder die Eingabefelder innerhalb des Popups (von oben nach unten).
* **Fokus 3 (Aktionsbuttons):** Die Aktions-Buttons am unteren Rand des Popups (z.B. links „Abbrechen“, rechts „Bestätigen“).
* **Fokus 4 (Schließen-Button):** Der Schließen-Button (falls dieser als separates Icon oben platziert ist). *Alternativ kann der Schließen-Button auch direkt als Fokus 2 nach der Überschrift angesteuert werden.*

---

## 4. Implementierung (SwiftUI)

### Good Pattern (Positivbeispiel)
Dieses Beispiel zeigt eine empfohlene, barrierefreie Implementierung eines Popups, welche native Komponenten nach den Apple Human Interface Guidelines verwendet.
```swift
import SwiftUI

struct GoodModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            // ScrollView verhindert den Layout-Kollaps bei großen Systemschriften
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("Möchten Sie diesen Eintrag wirklich unwiderruflich löschen? Diese Aktion kann nicht rückgängig gemacht werden.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    // Haupt-Aktionsbutton
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Eintrag unwiderruflich löschen")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .minTouchTargetSize() // Sicherstellung der Klickfläche
                            .background(Color.red)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Alternativer Abbrechen-Button.
                    Button(action: { isPresented = false }) {
                        Text("Abbrechen")
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .padding()
                            .minTouchTargetSize()
                    }
                }
                .padding(.vertical)
            }
            // Titel des Popups als Navigationstitel setzen (wird nativ als Header vorgelesen).
            .navigationTitle("Eintrag löschen")
            .navigationBarTitleDisplayMode(.inline)
            // Schließen-Button in der Toolbar
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundColor(.secondary)
                            // Mindestgröße von 44x44pt.
                            .frame(width: 44, height: 44) 
                    }
                    // Verhindert das Vorlesen von "xmark" und gibt klare Anweisung
                    .accessibilityLabel("Schließen")
                }
            }
        }
    }
}

// Hilfreicher ViewModifier, um konsistent Touch-Targets von 44pt zu erzwingen
extension View {
    func minTouchTargetSize() -> some View {
        self.frame(minWidth: 44, minHeight: 44)
    }
}
```
**Wie das Popup aufgerufen wird:**
Das native .sheet SwiftUI kapselt die Ansicht automatisch so ab, dass Nutzer von Screenreadern nicht versehentlich Elemente im Hintergrund aktivieren können (Focus Trap):
```swift
struct MainContentView: View {
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Button("Zeige Modal") {
                showModal = true
            }
        }
        // Das native .sheet sorgt automatisch für Barrierefreiheit bezüglich des Hintergrunds
        .sheet(isPresented: $showModal) {
            GoodModalView(isPresented: $showModal)
                // Unterbindet das Schließen per einfachem "Swipe-Down", um versehentliche Aktionen zu verhindern.
                .interactiveDismissDisabled(true) 
        }
    }
}
```

### Bad Pattern (Negativbeispiel)
Dieses Beispiel zeigt eine typisch fehlerhafte Implementierung eines Popups. Sie ignoriert zentrale Vorgaben bezüglich Accessibility-Label, Fokusfalle sowie einen fehlenden Schließen-Button.

```swift
import SwiftUI

struct BadModalView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 15) {
            
            // BARRIERE: Keine Deklaration als Überschrift für den Screenreader
            Text("Eintrag löschen")
                .font(.title2)
                .bold()
                .padding(.top, 20)
            
            Text("Möchten Sie diesen Eintrag wirklich unwiderruflich löschen? Diese Aktion kann nicht rückgängig gemacht werden.")
                .font(.body)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // BARRIERE: Es gibt keinen sichtbaren "Abbrechen"- oder "Schließen"-Button.
            Button(action: { isPresented = false }) {
                Text("Löschen")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        // BARRIERE: Feste Höhe führt bei Dynamic Type zu Layout-Problemen.
        .frame(height: 250) 
        .background(Color(.systemBackground))
    }
}
```

**Wie das Popup aufgerufen wird:**
Das Bad Pattern Popup wird durch folgende View aufgerufen:
```swift
import SwiftUI

struct MainContentView: View {
    @State private var showBadModal = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Barrierefreiheits-Testumgebung")
                .font(.title)
                .bold()
            
            Button(action: {
                showBadModal = true
            }) {
                Text("Bad Pattern Modal öffnen")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(10)
            }
        }
        // Hier wird das fehlerhafte Popup aufgerufen
        .sheet(isPresented: $showBadModal) {
            BadModalView(isPresented: $showBadModal)
        }
    }
}
```
