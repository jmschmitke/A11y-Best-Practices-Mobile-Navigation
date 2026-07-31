# A11y Best Practices Mobile Navigation

Ausgewählte Sprache: Deutsch

Andere Sprachen: [English](README_en.md)

---

Willkommen bei der **Accessible Mobile Navigation Pattern Library**. Dieses Projekt dient als Brücke zwischen theoretischen Barrierefreiheits-Richtlinien (wie der WCAG 2.2 und der EN 301 549) und der praktischen Umsetzung in der mobilen Softwareentwicklung für **iOS (SwiftUI)** und **Android (Kotlin)**.

Das Ziel dieses Repositories ist es, Entwickelnden und Designenden direkt einsetzbare, barrierefreie UI/UX-Muster an die Hand zu geben und gleichzeitig für typische Barrieren in der Praxis zu sensibilisieren.

---

## Das Konzept: Theorie trifft Praxis

Jedes Pattern in dieser Bibliothek folgt einem standardisierten Aufbau, um den Wissenstransfer so einfach wie möglich zu gestalten:
1. **Kontext und Problemstellung:** Reale Nutzungsszenarien und Barrieren für Menschen mit Einschränkungen.
2. **Relevante Richtlinien und Standards:** Direkte Verknüpfung mit WCAG 2.2 und EN 301 549.
3. **Design-Spezifikationen (UI/UX):** Kontraste, Touch-Targets und erwartete Screenreader-Reihenfolge.
4. **Implementierung (SwiftUI & Kotlin):** Code-Gegenüberstellung eines **Good Patterns** und eines **Bad Patterns**.
5. **Quellen:** Weiterführende Dokumente.

---

## Inhaltsverzeichnis: Die 10 Patterns

Hier findest du die Dokumentation der einzelnen UI-Komponenten und Navigationsstrukturen. Die Dateien liegen im Ordner `patterns/`:

*   **[01: Suche](patterns/01_search_de.md)**
*   **[02: Fußzeile & Kopfzeile](patterns/02_footer_header_de.md)**
*   **[03: Popup](patterns/03_modals_de.md)**
*   **[04: Tabs](patterns/04_tabs_de.md)**
*   **[05: Cards](patterns/05_cards_de.md)**
*   **[06: Karussel](patterns/06_carousel_de.md)**
*   **[07: Gesten](patterns/07_gestures_de.md)**
*   **[08: Navigationsstruktur & Layout](patterns/08_navigation_layout_de.md)**
*   **[09: Filter](patterns/09_filtering_items_de.md)**
*   **[10: Eingabefehler](patterns/10_showing_input_error_de.md)**

---

## Referenz-Apps

Um die Patterns nicht nur in der Theorie zu lesen, sondern auch am eigenen Gerät (oder im Simulator) zu erleben, beinhaltet das Projekt im Ordner `reference_apps/` zwei vollständig lauffähige Codebases:

### 🔴 Die "Bad Pattern" App
*   **Zweck:** Demonstration von Anti-Patterns.
*   **Inhalt:** Implementiert bewusst die unzugänglichen Varianten (z.B. starre Layouts, die bei Dynamic Type brechen, fehlende Accessibility-Labels, exklusive Gesten).
*   **Ziel:** Ideal, um das Testen mit VoiceOver/TalkBack zu üben und zu verstehen, wie Barrieren die Bedienung blockieren.

### 🟢 Die "Good Pattern" App
*   **Zweck:** Best-Practice-Referenz.
*   **Inhalt:** Zeigt die guten Pattern auf Basis nativer Implementierungen.
*   **Ziel:** Dient als Positivbeispiel, wie eine barrierefreie Implementierung Nutzende bei der Bedienung der App unterstützt.

---

## Technologien & Standards

Die Library basiert auf folgenden Richtlinien:
*   [WCAG 2.2 (Web Content Accessibility Guidelines)](https://www.w3.org/TR/WCAG22/)
*   [EN 301 549](https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf)
*   [Apple HIG](https://developer.apple.com/design/human-interface-guidelines)
