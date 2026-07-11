# 06: Carousel

Ausgewählte Sprache: Deutsch

Andere Sprachen: tbd

---

<details>
  <summary><b>Inhaltsverzeichnis Pattern</b> (Klicken zum Ausklappen)</summary>
  <br>

  * [Search](01_search_de.md)
  * [Footer & Header](02_footer_header_de.md)
  * [Modal (Popup)](03_modals_de.md)
  * [Tabs (Registerkarten)](04_tabs_de.md)
  * [Cards (Karten-Komponenten)](05_cards_de.md)
  * Carousel (Karussell / Slider) <b>(Aktuell ausgewählt)</b>

</details>

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Carousels – z.B. als Image-Slider, Pager oder Banner-Rotator – präsentieren eine Reihe von Inhalten (meist Bilder, Teaser oder Cards) auf demselben visuellen Raum. Nutzende können sich sequenziell durch die Elemente wischen oder klicken. Da sich Inhalte hierbei teilweise außerhalb des sichtbaren Bildschirms befinden oder automatisch rotieren, bergen Carousels extrem hohe Barrieren, wenn sie nicht präzise für assistive Technologien optimiert werden.

### Typische Barrieren in der Praxis
* **Autoplay-Falle**: Automatisch rotierende Carousels, die sich nicht pausieren lassen, machen eine App für viele Menschen unbedienbar. Nutzende mit kognitiven Einschränkungen oder geringer Lesegeschwindigkeit werden gestresst, wenn der Text verschwindet, bevor sie ihn erfasst haben. Screenreader-Nutzende werden desorientiert, wenn sich der Inhalt unter ihrem Fokus plötzlich von alleine austauscht.
* **Unsichtbare Inhalte**: Befindet sich ein Element außerhalb des sichtbaren Bereichs, wird es von Screenreadern oft komplett ignoriert oder fälschlicherweise als fokussierbar erfasst, obwohl es visuell abgeschnitten ist. Ohne eine klare Ansage der Gesamtanzahl (z.B. „Element 2 von 5“) wissen blinde Nutzende nicht, dass weitere Inhalte existieren.
* **Unzugängliche Seitenindikatoren**: Die kleinen Punkte (Page Indicator Dots) am unteren Rand eines Sliders werden oft als rein dekorative Elemente oder mit nicht-assistiven Custom-Views gebaut. Sie besitzen dann keine Rolle, kein Label und sind weder für VoiceOver noch für externe Tastaturen ansteuerbar.
* **Wisch-Zwang**: Verlässt sich ein Carousel ausschließlich auf die Touch-Geste des horizontalen Wischens, schließt es Menschen mit motorischen Einschränkungen aus, die die App über Schaltersteuerung, Tastatur oder Eyetracker bedienen.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.

| Barrierefreiheits-Anforderung | WCAG 2.2 Kriterium | EN 301 549 | Relevanz für das Carousel-Pattern |
| :--- | :--- | :--- | :--- |
| **Informationen & Beziehungen** | 1.3.1 Info and Relationships | 11.1.3.1 | Die Slider-Elemente müssen strukturell als zusammenhängende Gruppe oder Liste definiert sein. |
| **Automatisches Aktualisieren** | 2.2.2 Pause, Stop, Hide | 11.2.2.2 | Jedes Carousel, das automatisch startet und länger als 5 Sekunden rotiert, MUSS einen gut erreichbaren Pause-Button besitzen. |
| **Kontrast (Minimum)** | 1.4.3 Contrast (Minimum) | 11.1.4.3 | Der Text auf der Info muss sich vom Hintergrund abheben (mind. 4,5:1). Text auf Bild-Overlays benötigt oft schattierte Hintergründe. |
| **Text vergrößern** | 1.4.4 Resize Text | 11.1.4.4 | Carousels dürfen keine feste Höhe haben. Bei Dynamic Type muss das Carousel vertikal mitwachsen, ohne Text abzuschneiden oder zu überlagern. |
| **Nicht-Text-Kontrast** | 1.4.11 Non-Text Contrast | 11.1.4.11 | Der Kontrast der Rahmenlinien zum Hintergrund muss mindestens 3:1 betragen. |
| **Tastatur-Bedienbarkeit** | 2.1.1 Keyboard | 11.2.1.1 | Der Folienwechsel muss über Tastatur (z. B. Pfeiltasten oder explizite Vor-/Zurück-Buttons) möglich sein. |
| **Fokus-Reihenfolge** | 2.4.3 Focus Order | 11.2.4.3 | Elemente außerhalb des sichtbaren Bildschirms dürfen erst in die Fokus-Reihenfolge gelangen, wenn sie aktiv hineingescrollt wurden. |
| **Fokus sichtbar** | 2.4.7 Focus Visible | 11.2.4.7 | Beim Fokussieren eines Inhaltes per Tastatur muss diese  Info einen deutlich erkennbaren Fokusrahmen erhalten. |
| **Zeigergesten** | 2.5.1 Pointer Gestures | 11.2.5.1 | Wenn das Carousel eine Wisch-Geste unterstützt, muss das Vor- und Zurückblättern auch über eine einfache Zeigerinteraktion möglich sein. |
| **Zielgröße (Minimum)** | 2.5.8 Target Size (Min) | 11.2.5.8 | Visuelle Steuerungselemente (Pfeile, Punkte, Pause-Button) benötigen eine Touch-Fläche von mind. 44x44pt. |
| **Name, Rolle, Wert** | 4.1.2 Name, Role, Value | 11.4.1.2 | Der aktuelle Zustand (z. B. „Folie 1 von 4“) und die Steuerungsknöpfe müssen eindeutige Namen und Rollen besitzen. |

---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* **Explizite Navigationselemente**: Nicht auf Gesten verlassen. Ein barrierefreies Carousel benötigt visuelle Vor- und Zurück-Buttons oder klar definierte, klickbare Seitenindikatoren, damit die Steuerung präzise und barrierefrei bleibt.
* **Kontrast der Indikatoren**: Die Page-Indicator-Punkte müssen einen Kontrast von mindestens 3:1 zum Hintergrund aufweisen. Der aktive Punkt muss sich zusätzlich durch Form, Größe oder einen deutlich stärkeren Kontrast (z.B. 4,5:1 beim Text-Label) von den inaktiven Punkten abheben.
* **Visueller Pause-Button**: Wenn Autoplay active ist, muss ein dauerhaft sichtbarer Pause-Button angeboten werden. Alternativ muss die Rotation dauerhaft stoppen, sobald der Screenreader-Fokus das Carousel betritt oder ein Nutzer die Komponente berührt.

### Interaktionsdesign und Touch-Targets
* **Umgang mit Klickflächen**: Da die Indikator-Punkte visuell oft sehr klein designt werden (z.B. 8x8 pt), muss ihre physische Touch-Fläche im Code unsichtbar auf mindestens 44x44 pt vergrößert werden. Alternativ empfiehlt es sich, die Punkte rein dekorativ zu schalten und stattdessen größere Pfeiltasten zu verwenden.
* **Barrierefreies Scroll-Verhalten**: Beim manuellen Wischen sollte das Carousel präzise auf dem nächsten Element einrasten, damit Inhalte nicht halb abgeschnitten am Bildschirmrand stehen bleiben.

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
1. **Fokus 1:** Beim Betreten des Carousels kündigt VoiceOver das Element idealerweise als Gruppe an: „Karussell, Highlight-Themen“.
2. **Fokus 2:** Der Fokus springt direkt auf das aktuell sichtbare Inhaltselement (z.B. die aktive Card). VoiceOver liest den Inhalt vor und fügt die Positionsangabe hinzu: „[Inhalt], Element 1 von 3“.
3. **Fokus 3 & 4:** Danach folgen die Buttons „Nächstes Element“, „Vorheriges Element“ und der optionale „Pause“-Button.
4. **Ignorieren inaktiver Elemente:** Elemente, die sich aktuell unsichtbar außerhalb des Bildschirms befinden, werden komplett vom Fokus-Fluss ausgeschlossen (`accessibilityHidden(true)`), bis sie aktiv hineingescrollt werden.

---

## 4. Implementierung (SwiftUI)

### Good Pattern (Positivbeispiel)
Dieses Beispiel zeigt eine barrierefreie Implementierung. Es nutzt eine TabView im Page-Stil. Unsichtbare Seiten werden nativ vor dem Screenreader verborgen. Zusätzlich sind explizite, ausreichend große Buttons zur Steuerung verbaut, und das gesamte Konstrukt ist für VoiceOver als logische Gruppe erkennbar.
```swift
import SwiftUI

struct GoodCarouselView: View {
    let items = ["Angebot 1", "Angebot 2", "Angebot 3"]
    @State private var currentIndex = 0

    var body: some View {
        VStack(spacing: 16) {
            // Native Page-TabView: Regelt Barrierefreiheit für Folien-Zustände automatisch
            TabView(selection: $currentIndex) {
                ForEach(items.indices, id: \.self) { index in
                    Text(items[index])
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.blue)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never)) // Versteckt unzugängliche native Dots
            .frame(height: 150)
            // Zusammenfassen zu einer barrierefreien Gruppe
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Karussell, Highlight-Themen. \(items[currentIndex]), Element \(currentIndex + 1) von \(items.count)")
            
            // Alternative Steuerungselemente (Pfeiltasten)
            HStack(spacing: 40) {
                Button(action: { if currentIndex > 0 { currentIndex -= 1 } }) {
                    Image(systemName: "chevron.left")
                        .frame(width: 44, height: 44) // WCAG 2.5.8: Mindest-Touch-Fläche
                }
                .accessibilityLabel("Vorheriges Element")
                .disabled(currentIndex == 0)

                Button(action: { if currentIndex < items.count - 1 { currentIndex += 1 } }) {
                    Image(systemName: "chevron.right")
                        .frame(width: 44, height: 44)
                }
                .accessibilityLabel("Nächstes Element")
                .disabled(currentIndex == items.count - 1)
            }
        }
        .padding()
    }
}
```


### Bad Pattern (Negativbeispiel)
Dieses Beispiel zeigt eine mangelhafte Implementierung mittels HStack-ScrollView. Es zwingt zum Wischen, versteckt unsichtbare Elemente nicht vor dem VoiceOver und nutzt sehr kleine Custom-Punkte zur Steuerung abseits der Wischgesten.
```swift
import SwiftUI

struct BadCarouselView: View {
    let items = ["Angebot 1", "Angebot 2", "Angebot 3"]
    @State private var currentIndex = 0

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                // BARRIERE: ScrollView fängt Fokus für inaktive Elemente ein, kein Einrasten
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(items.indices, id: \.self) { index in
                            Text(items[index])
                                .frame(width: 300, height: 150)
                                .background(Color.red)  // BARRIERE: Schlechter Kontrast
                                .id(index)
                        }
                    }
                }
                .onChange(of: currentIndex) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
            
            // Barriere: Custom Page Indicator Punkte mit einer viel zu kleinen Größe (8x8)
            HStack {
                ForEach(items.indices, id: \.self) { index in
                    Circle()
                        .fill(currentIndex == index ? Color.black : Color.gray)
                        .frame(width: 8, height: 8)
                        .onTapGesture { 
                            currentIndex = index // Ändert jetzt den Index beim Klicken
                        }
                }
            }
        }
    }
}
```
