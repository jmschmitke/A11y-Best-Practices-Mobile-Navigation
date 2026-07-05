# 01: Footer&Header

Ausgewählte Sprache: Deutsch

Andere Sprachen: [Englisch](01_search_en.md)

---

## 1. Kontext und Problemstellung

### Nutzungskontext
Header (z. B. NavigationBar in iOS) und Footer (z. B. TabBar oder Toolbar) bilden den strukturellen Rahmen einer App. Der Header dient meist der Orientierung (Anzeige des aktuellen Screen-Namens, Zurück-Button, Profil- oder Einstellungs-Icons). Der Footer verankert die primären Navigationsziele der App auf der obersten Ebene oder bietet kontextuelle Aktionen am unteren Bildschirmrand. Da diese Elemente permanent sichtbar sind, müssen sie maximale Konsistenz und fehlerfreie Zugänglichkeit garantieren.

### Typische Barrieren in der Praxis
* Layout-Bruch bei Textvergrößerung: Wenn Nutzende die Systemschriftgröße (Dynamic Type) stark erhöhen, kollidieren statisch programmierte Titel und Icons im Header. Text wird unleserlich abgeschnitten oder Steuerelemente überlagern sich, wodurch wichtige Funktionen unbedienbar werden.
* Kognitive Hürden durch reine Icon-Navigation: Aus Platzgründen wird im Footer oft auf Text-Labels unter den Navigations-Symbolen verzichtet. Für blinde, sehbehinderte oder kognitiv eingeschränkte Menschen sind abstrakte Symbole ohne eindeutige Textbeschreibung jedoch kaum fehlerfrei zu interpretieren.
* Unerreichbare Touch-Targets an den Bildschirmrändern: Da Header ganz oben und Footer ganz unten platziert sind, rutschen interaktive Buttons gefährlich nah an die physischen Displayränder. Ohne eine großzügige, unsichtbare Klickfläche von mindestens 44x44pt sind sie motorisch extrem schwer zu treffen.
* Unlogische Fokus-Reihenfolge und Navigationsfallen: Wenn Inhaltsbereiche scrollbar sind, verlieren Apps oft die Kontrolle über den linearen Lesefluss von Screenreadern. Nutzende geraten beim Wischen in Endlosschleifen innerhalb des Hauptinhalts und können den Footer oder die Tab-Bar überhaupt nicht mehr erreichen.

---

## 2. Relevante Richtlinien und Standards

Die folgende Tabelle zeigt den Zusammenhang zwischen technischen Erfolgskriterien der **WCAG 2.2** und der Regelung innerhalb von Kapitel 11 der **EN 301 549**.



---

## 3. Design-Spezifikationen (UI/UX)

### Visuelle Gestaltung und Kontraste
* Dynamic Type Support: Header und Footer dürfen keine feste, statische Höhe in pt besitzen. Sie müssen dynamisch mitwachsen, wenn Nutzende die Systemschriftgröße ändern. Text-Labels in der TabBar dürfen bei maximaler Vergrößerung zweizeilig werden oder in ein vertikales Stack-Layout wechseln.
* Zwingende Text-Kombination: Jedes Icon im Footer muss von einem permanenten, gut lesbaren Text-Label begleitet werden. Reine Icon-Navigation ist unzulässig.
* Kontrastlinien: Da Header und Footer oft farblich mit dem Hauptinhalt verschmelzen, ist eine visuelle Trennlinie (Separator) mit einem Kontrast von mindestens 3:1 zum Hintergrund zwingend erforderlich, um die strukturellen Zonen der App kognitiv klar abzugrenzen.

### Interaktionsdesign und Touch-Targets
* Safe Area Einbettung: Elemente im Header und Footer müssen strikt innerhalb der vom System vorgegebenen Safe Area liegen, um Überlagerungen mit der Statusleiste (oben) oder dem Home-Indicator (unten) zu verhindern.
* Touch-Flächen: Jedes interaktive Element (z. B. der „Edit“-Button im Header oder ein Tab im Footer) muss eine physische Touch-Fläche von mindestens 44 x 44 pt garantieren. Bei 4-5 Tabs im Footer teilt sich die Breite meist automatisch auf, die Höhe muss jedoch strikt eingehalten werden.

### Empfohlene Fokus-Reihenfolge (VoiceOver / Tastatur)
1. **Fokus 1:** Der Header-Titel (deklariert als Überschrift / Heading). VoiceOver liest: „[Titel], Überschrift“.*
2. **Fokus 2 (Bedingt):** Optionale Funktionstasten im Header (links/rechts) von links nach rechts geordnet.*
3. **Fokus 3:** Der Hauptinhalt (Main Content) des Screens.*
3. **Fokus 4:** Die Tab-Bar im Footer. Beim Wechsel auf ein Element liest VoiceOver: „Home, Tab, 1 von 4, ausgewählt“. Der ausgewählte Zustand ist elementar!
