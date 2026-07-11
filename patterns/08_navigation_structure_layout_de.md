# 08: Navigationsstruktur & Layout

Ausgewählte Sprache: Deutsch

Andere Sprachen: tbd

---

<details>
  <summary><b>Inhaltsverzeichnis Pattern</b> (Klicken zum Ausklappen)</summary>
  <br>

  * [Suche](01_search_de.md)
  * [Fußzeile & Kopfzeile](02_footer_header_de.md)
  * [Popup](03_modals_de.md)
  * [Tabs](04_tabs_de.md)
  * [Cards](05_cards_de.md)
  * [Karussel](06_carousel_de.md)
  * [Gesten](07_gestures_de.md)
  * Navigationsstruktur & Layout <b>(Aktuell ausgewählt)</b>
  * [Filter](09_filtering_items_de.md)
  * [Eingabefehler](10_showing_input_error_de.md)

</details>

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Eine konsistente Navigationsstruktur und ein logisches, vorhersehbares Seitenlayout bilden das Rückgrat jeder barrierefreien Anwendung. Sie ermöglichen es Nutzenden, eine Karte der App oder Website aufzubauen, Inhalte schnell zu lokalisieren und effizient zwischen Sektionen zu wechseln. Ein sauberes Layout ordnet Elemente hierarchisch an (z.B. primäre Navigation, Hauptinhalt, sekundäre Seitenbereiche, Footer). Da Menschen mit Sehbehinderungen oder kognitiven Einschränkungen oft stark auf eine gleichbleibende Orientierung angewiesen sind, dürfen sich grundlegende Layout- und Navigationsmechanismen innerhalb einer Anwendung niemals unerwartet verändern.

### Typische Barrieren in der Praxis
* **Mangelnde Orientierung**: Wenn das Navigationsmenü auf der Startseite oben platziert ist, auf Unterseiten jedoch in einem Burger-Menü versteckt wird oder sich die Reihenfolge der Menüpunkte permanent ändert, desorientiert dies Menschen mit kognitiven Einschränkungen. Auch Screenreader-Nutzende verlieren die Orientierung, wenn wiederkehrende Layout-Blöcke jedes Mal anders angeordnet sind.
* **Mangelhafte Navigationseffizienz für Tastaturnutzende**: Für Personen, die eine Anwendung ausschließlich mit der Tastatur oder einem Switch-Control-Gerät bedienen, ist eine große, kopfzeilenbasierte Navigation mit vielen Unterpunkten ein Hindernis. Ohne sogenannte „Sprunglinks“ müssen sie bei jedem Seitenwechsel mühsam oft die Tab-Taste drücken, nur um am Menü vorbei zum eigentlichen Hauptinhalt der Seite zu gelangen.
* **Fehlende semantische Regionen**: Wenn ein Layout visuell zwar klar in Kopfzeile, Hauptbereich und Fußzeile unterteilt ist, diese Bereiche im Code aber nicht semantisch als Regionen (Landmarks wie `<header>`, `<main>`, `<nav>`, `<footer>`) deklariert sind, ist die Seite für Screenreader als strukturlose Textlandschaft. Blinde Nutzende können dann nicht gezielt per Tastaturbefehl direkt zum Hauptinhalt springen.
* **Layout-Bruch bei responsiver Skalierung**: Wenn die Bildschirmausrichtung wechselt (Querformat/Landscape) oder die Schriftgröße über Dynamic Type drastisch erhöht wird, kollabieren starre Layouts oft. Navigationselemente überlagern dann den Text, Buttons rutschen aus dem klickbaren Bereich oder wichtige Navigationspfade verschwinden komplett, ohne dass ein alternatives Scrollen möglich ist.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.

| Barrierefreiheits-Anforderung | WCAG 2.2 Kriterium | EN 301 549 | Relevanz für das Navigations-Pattern |
| :--- | :--- | :--- | :--- |
| **Informationen & Beziehungen** | 1.3.1 Info and Relationships | 11.1.3.1 | Layout-Bereiche müssen durch semantische Regionen/Landmarks (Kopfzeile, Navigation, Hauptinhalt, Fußzeile) ausgezeichnet sein. |
| **Bedeutungsvolle Reihenfolge** | 1.3.2 Meaningful Sequence | 11.1.3.2 | Die programmatische Fokus- und Lesereihenfolge (Code-Struktur) muss exakt der visuellen Leserichtung von oben nach unten, links nach rechts entsprechen. |
| **Ausrichtung** | 1.3.4 Orientation | 11.1.3.4 | Die App darf die Anzeige nicht starr auf Hoch- oder Querformat sperren, es sei denn, es ist technisch zwingend erforderlich. |
| **Reflow (Anpassbarer Inhalt)** | 1.4.10 Reflow | 11.1.4.10 | Das Layout muss bis zu einer extremen Vergrößerung bzw. in Hoch- und Querformat funktionieren, ohne dass Inhalte verloren gehen oder horizontal gescrollt werden muss (außer bei Tabellen/Karten). |
| **Blöcke überspringen** | 2.4.1 Bypass Blocks | 11.2.4.1 | Es müssen Mechanismen (z.B. Skip-to-Content-Links) bereitgestellt werden, um wiederkehrende Navigationsblöcke direkt zu überspringen. |
| **Seite mit Titel** | 2.4.2 Page Titled | 11.2.4.2 | Jede Seite/Ansicht muss einen eindeutigen, aussagekräftigen Titel haben. |
| **Mehrere Wege** | 2.4.5 Multiple Ways | 11.2.4.5 | Inhalte müssen über mehr als einen Weg auffindbar sein (z.B. Kombination aus globaler Navigation, Suchfunktion und einer Sitemap/Footer-Übersicht). |
| **Standort** | 2.4.8 Location | 11.2.4.8 | Informationen über den aktuellen Standort innerhalb einer Reihe von Seiten müssen verfügbar sein. |
| **Konsistente Navigation** | 3.2.3 Consistent Navigation | 11.3.2.3 | Navigationsmechanismen, die sich über mehrere Seiten wiederholen, müssen bei jedem Auftreten an derselben relativen Position stehen. |
| **Konsistente Identifikation** | 3.2.4 Consistent Identification | 11.3.2.4 | Komponenten mit derselben Funktionalität (z.B. das Einstellungs-Icon oder der Home-Button) müssen app-weit identisch benannt und gestaltet sein. |

---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* **Visuelle Hierarchie durch klare Zonen**: Das Layout muss stabile, wiederkehrende Zonen besitzen. Die primäre Navigation (z.B. Tab-Bar am unteren Bildschirmrand bei Mobile oder Seitenleiste bei Desktop) bleibt stets an derselben Stelle.
* **Orientierungs-Indikatoren**: Das aktuell aktive Element innerhalb der Navigation muss visuell unmissverständlich hervorgehoben sein (z.B. durch eine Kombination aus kontraststarker Farbe, dicker Unterstreichung und einer Textänderung wie „[Name], aktiv“ im nicht-visuellen Kontext).
* **Verlustfreie Ausrichtung**: Die Anwendung darf die Bildschirmausrichtung nicht starr auf Hoch- oder Querformat sperren (außer bei technisch zwingenden Ausnahmen wie Bankomaten-Scans). Das Layout muss flexibel fließen, wenn Nutzende ihr Gerät (z.B. am Rollstuhl montiert) im Querformat betreiben.

### Interaktionsdesign und Touch-Targets
* **Erreichbarkeit von Navigationselementen**: Navigationsmenüs müssen für Einhandbedienung optimiert sein. Auf Mobilgeräten empfiehlt sich daher eine primäre Navigation am unteren Bildschirmrand, da die oberen Ecken für Menschen mit motorischen Einschränkungen schwer zu erreichen sind.
* **Tastatur-Landmarken-Navigation**: Die App- oder Webstruktur muss so implementiert sein, dass Nutzende assistiver Technologien mithilfe von Schnelltasten (z.B. Taste `R` bei NVDA/JAWS oder dem Rotor bei VoiceOver) direkt von Landmarke zu Landmarke springen können (z.B. direkt zum Hauptinhalt oder direkt zur Suche).

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
* **Fokus 1 (Sprunglink / Optional im Web):** Beim ersten Druck auf die `Tab`-Taste erscheint ganz oben ein visuell eingeblendeter Button „Direkt zum Hauptinhalt springen“. Wird dieser aktiviert, überspringt der Fokus die komplette Navigation.
* **Fokus 2 (Kopfzeile / Header Landmark):** Wird der Sprunglink übergangen, wandert der Fokus logisch in die Kopfzeile. Screenreader kündigen die Zone an: „Banner / Kopfzeile, Gruppe“.
* **Fokus 3 (Navigationsbereich / Navigation Landmark):** Der Fokus arbeitet sich sequenziell durch die Menüpunkte der primären Navigation.
* **Fokus 4 (Hauptinhalt / Main Landmark):** Der Fokus verlässt die Navigation und betritt den Kerninhalt der aktuellen Seite. Screenreader sagen an: „Hauptinhalt, Region“.
* **Fokus 5 (Fußzeile / Footer Landmark):** Schließlich werden die ergänzenden Links im Footer angesteuert.

---

## 4. Implementierung (SwiftUI)

### Good Pattern (Positivbeispiel)
Dieses Beispiel nutzt die nativen Komponenten NavigationStack und TabView. Dadurch werden die Bereiche für Screenreader automatisch korrekt übersetzt, der Seitentitel wird dynamisch mitgeteilt, und das Layout bricht bei großen Schriften oder im Querformat nicht zusammen.
```swift
import SwiftUI

struct GoodNavigationView: View {
    var body: some View {
        // Native TabView: Liefert konsistente Struktur und semantische Landmarks
        TabView {
            NavigationStack { // Nativer Stack: Regelt Fokus-Reihenfolge und Navigation
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Hauptinhalt der App")
                            .font(.body)
                    }
                    .padding()
                }
                // WCAG 2.4.2: Jede Ansicht erhält einen eindeutigen, programmatischen Titel
                .navigationTitle("Dashboard")
            }
            .tabItem {
                // Konsistente Identifikation und Text-Labels für Steuerelemente
                Label("Home", systemImage: "house.fill")
            }
            
            Text("Einstellungen")
                .tabItem {
                    Label("Einstellungen", systemImage: "gearshape")
                }
        }
        // Kein Sperren der Orientierung, Layout fließt flexibel in Landscape und Portrait
    }
}
```


### Bad Pattern (Negativbeispiel)
Dieses Beispiel erzwingt starre Höhen, wodurch Text bei großen Schriften (Dynamic Type) abgeschnitten wird. Es sperrt die App künstlich per Code in das Hochformat und ignoriert native, konsistente Navigationselemente zugunsten einer unbeschrifteten Custom-Leiste.
```swift
import SwiftUI

struct BadNavigationView: View {
    var body: some View {
        VStack(spacing: 0) {
            // BARRIERE: Starre Höhe schneidet Text bei Dynamic Type / Skalierung ab.
            HStack {
                Text("Mein Dashboard")
                    .font(.headline)
            }
            .frame(height: 50)
            
            ScrollView {
                VStack {
                    Text("Hauptinhalt der App")
                }
            }
            
            // BARRIERE: Selbstgebaute Tab-Leiste ohne semantische Navigation-Rolle.
            // BARRIERE: Icons besitzen keine Text-Labels oder Barrierefreiheits-Namen.
            HStack {
                Spacer()
                Image(systemName: "house.fill")
                Spacer()
                Image(systemName: "gearshape")
                Spacer()
            }
            .frame(height: 60) // BARRIERE: Fixe Höhe verhindert vertikales Mitwachsen
        }
        // BARRIERE: Starr erzwungene Orientierung.
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}
```

---

## 5. Implementierung (Kotlin)
Wird noch erstellt...
