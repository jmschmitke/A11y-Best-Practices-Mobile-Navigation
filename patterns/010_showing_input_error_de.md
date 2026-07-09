# 10: Showing Input Error

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
  * [Carousel (Karussell / Slider)](06_carousel_de.md)
  * [Gestures (Gesten-Steuerung)](07_gestures_de.md)
  * [Navigation Structure & Layout](08_navigation_layout_de.md)
  * [Filtering Items](09_filtering_items_de.md)
  * Showing Input Error <b>(Aktuell ausgewählt)</b>

</details>

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Eingabemasken und Formulare (z.B. bei der Registrierung, beim Checkout oder bei Kontaktdaten) sind anfällige Interaktionspunkte in fast jeder Applikation. Fehler bei der Dateneingabe treten regelmäßig auf – sei es durch Tippfehler, ein falsches Format (z.B. bei E-Mail-Adressen) oder das Übersehen eines Pflichtfeldes. Das barrierefreie Anzeigen von Fehlermeldungen sorgt dafür, dass Nutzende sofort erkennen, dass ein Fehler aufgetreten ist, wo er sich befindet und wie er behoben werden kann. Da Fehlersituationen oft zu Frustration führen, ist eine kognitiv einfache und assistiv zugängliche Fehlerführung unerlässlich.

### Typische Barrieren in der Praxis
* **Reine Farbsignalisierung**: Ein Fehler in der Praxis ist es, ein fehlerhaftes Eingabefeld lediglich mit einem roten Rahmen zu versehen. Für farbblinde, fehlsichtige oder blinde Nutzende ist diese visuelle Änderung unsichtbar. Ohne begleitenden Text oder ein eindeutiges Icon bleibt der Fehler unbemerkt.
* **Kryptische Fehlermeldungen**: Meldungen wie *„Ungültige Eingabe“* oder *„Fehlercode 403“* helfen Nutzenden nicht weiter. Besonders Menschen mit kognitiven Einschränkungen oder geringer digitaler Erfahrung werden dadurch blockiert. Die Meldung muss konkret beschreiben, was fehlt (z.B. *„Das Passwort muss mindestens 8 Zeichen lang sein“*).
* **Verbleiben des Fokus**: Klickt eine blinde Person auf „Absenden“ und das Formular lädt aufgrund von Validierungsfehlern asynchron nicht ab, bleibt der Screenreader oft starr auf dem Absende-Button. Die Person merkt nicht, dass weiter oben auf der Seite Fehlermeldungen aufgetaucht sind, und geht davon aus, dass die Aktion erfolgreich war.
* **Zugänglichkeits-Lücke zwischen Label und Text**: Wenn eine Fehlermeldung visuell unter einem Textfeld platziert wird, liest ein Screenreader beim Fokussieren des Feldes standardmäßig nur den Namen des Feldes vor (z.B. *„E-Mail-Adresse, Textfeld“*). Die darunterstehende Fehlermeldung wird übersprungen, da sie programmatisch nicht mit dem Eingabefeld verknüpft wurde.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.

| Barrierefreiheits-Anforderung | WCAG 2.2 Kriterium | EN 301 549 | Relevanz für das Fehler-Pattern |
| :--- | :--- | :--- | :--- |
| **Nutzung von Farbe** | 1.4.1 Use of Color | 11.1.4.1 | Fehler dürfen niemals ausschließlich über einen Farbwechsel (z. B. roter Rahmen) signalisiert werden. |
| **Fehlererkennung** | 3.3.1 Error Identification | 11.3.3.1 | Wenn ein Fehler erkannt wird, muss das fehlerhafte Element identifiziert und der Fehler dem Nutzer in Textform beschrieben werden. |
| **Fehlerkorrektur (Hilfe)** | 3.3.3 Error Suggestion | 11.3.3.3 | Wenn ein Fehler erkannt wird und Vorschläge zur Korrektur bekannt sind, müssen diese dem Nutzer verständlich bereitgestellt werden. |
| **Fehlervermeidung (Rechtliche/Finanzielle Daten)** | 3.3.4 Error Prevention (Legal, Financial, Data) | 11.3.3.4 | Bei Verträgen, Käufen oder Datenlöschungen müssen Eingaben überprüfbar, korrigierbar oder widerrufbar sein. |
| **Statusmeldungen** | 4.1.3 Status Messages | 11.4.1.3 | Beim Absenden auftretende Fehler müssen dynamisch so angekündigt werden, dass assistive Technologien sie sofort wahrnehmen. |

---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* **Mehrkanalanzeige**: Jede Fehlermeldung muss mindestens zwei visuelle Kanäle nutzen. Die Kombination aus Text (Fehlerbeschreibung), Farbe (z.B. Rot mit einem Kontrast von mind. 4,5:1 zum Hintergrund) und einem Icon (z.B. ein Warnsdreieck) ist Standard.
* **Platzierung der Meldung**: Fehlermeldungen sollten vorzugsweise direkt oberhalb oder direkt unterhalb des betroffenen Eingabefeldes platziert werden, um eine klare visuelle Nähe zu wahren.
* **Fehler-Sammelbox**: Bei längeren Formularen muss nach dem Absenden ganz oben auf der Seite eine prägnante Zusammenfassung aller aufgetretenen Fehler eingeblendet werden. Diese Box listet die Fehler als Link-Liste auf, sodass Nutzende per Klick direkt zum fehlerhaften Feld springen können.

### Interaktionsdesign und Touch-Targets
* **Fokus-Überführung bei Absendefehlern**: Schlägt das Absenden des Formulars fehl, muss der Fokus automatisch entweder auf die Fehler-Sammelbox am Seitenanfang oder direkt in das erste fehlerhafte Eingabefeld versetzt werden. Der Screenreader liest die Fehlermeldung dadurch sofort als Erstes vor.
* **Keine voreilige Validierung**: Eingabefelder sollten während des Tippens nicht sofort aggressiv Fehler anzeigen (z.B. während der Nutzer noch dabei ist, seine E-Mail-Adresse einzutippen). Die Validierung darf erst erfolgen, wenn das Feld verlassen wird (`Blur`-Event / Fokusverlust) oder das Formular abgesendet wird.
* **Erweiterte Verknüpfung**: Technisch muss das Eingabefeld so programmiert sein, dass die Fehlermeldung als Beschreibungstext des Feldes hinterlegt ist (z.B. im Web via `aria-describedby` oder in Native Mobile über das Verknüpfen der Accessibility-Labels). 

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
1. **Fokus 1 (Nach Klick auf Absenden):** Das Formular bricht ab, der Fokus springt an den Anfang der Fehler-Sammelbox. VoiceOver liest vor: *„Das Formular konnte nicht gesendet werden. 2 Fehler enthalten. Liste mit 2 Einträgen. Erstens: Passwort zu kurz, Link. Zweitens...“*
2. **Fokus 2 (Sprung zum Feld):** Der Nutzer aktiviert den ersten Link in der Fehlerbox. Der Fokus springt direkt in das fehlerhafte Textfeld.
3. **Fokus 3 (Das fehlerhafte Feld):** Da das Feld mit der Fehlermeldung verknüpft ist, liest der Screenreader sofort die Rolle und den Fehler in einem Stück vor: *„Passwort, sicheres Textfeld, fehlerhafte Eingabe. Das Passwort muss mindestens 8 Zeichen lang sein.“*

---
