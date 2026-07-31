# A11y Best Practices Mobile Navigation

Selected Language: English

Other Languages: [German](README.md)

---

Welcome to the **Accessible Mobile Navigation Pattern Library**. This project serves as a bridge between theoretical accessibility guidelines (such as WCAG 2.2 and EN 301 549) and practical implementation in mobile software development for **iOS (SwiftUI)** and **Android (Kotlin)**.

The goal of this repository is to provide developers and designers with ready-to-use, accessible UI/UX patterns while raising awareness of typical accessibility barriers in practice.

---

## The Concept: Theory Meets Practice

Every pattern in this library follows a standardized structure to make knowledge transfer as straightforward as possible:
1. **Context and Problem Statement:** Real-world usage scenarios and barriers for people with disabilities.
2. **Relevant Guidelines and Standards:** Direct links to WCAG 2.2 and EN 301 549.
3. **Design Specifications (UI/UX):** Color contrasts, touch targets, and expected screen reader order.
4. **Implementation (SwiftUI & Kotlin):** Code comparison between a **Good Pattern** and a **Bad Pattern**.
5. **Sources:** Further reading and references.

---

## Table of Contents: The 10 Patterns

Here you will find the documentation for individual UI components and navigation structures. The files are located in the `patterns/` folder:

*   **[01: Search](patterns/01_search_en.md)**
*   **[02: Header & Footer](patterns/02_footer_header_en.md)**
*   **[03: Popups / Modals](patterns/03_modals_en.md)**
*   **[04: Tabs](patterns/04_tabs_en.md)**
*   **[05: Cards](patterns/05_cards_en.md)**
*   **[06: Carousel](patterns/06_carousel_en.md)**
*   **[07: Gestures](patterns/07_gestures_en.md)**
*   **[08: Navigation Structure & Layout](patterns/08_navigation_layout_en.md)**
*   **[09: Filtering Items](patterns/09_filtering_items_en.md)**
*   **[10: Input Errors](patterns/10_showing_input_error_en.md)**

---

## Reference Apps

To not only read about the patterns in theory but also experience them on your own device (or simulator), the project includes two fully functional codebases in the `reference_apps/` folder:

### 🔴 The "Bad Pattern" App
*   **Purpose:** Demonstration of anti-patterns.
*   **Content:** Intentionally implements inaccessible variants (e.g., rigid layouts that break with Dynamic Type, missing accessibility labels, custom exclusive gestures).
*   **Goal:** Ideal for practicing testing with VoiceOver/TalkBack and understanding how barriers block usability.

### 🟢 The "Good Pattern" App
*   **Purpose:** Best-practice reference.
*   **Content:** Demonstrates good patterns based on native implementations.
*   **Goal:** Serves as a positive example of how an accessible implementation supports users while operating the app.

---

## Technologies & Standards

The library is based on the following guidelines:
*   [WCAG 2.2 (Web Content Accessibility Guidelines)](https://www.w3.org/TR/WCAG22/)
*   [EN 301 549](https://www.etsi.org/deliver/etsi_en/301500_301599/301549/03.02.01_60/en_301549v030201p.pdf)
*   [Apple HIG](https://developer.apple.com/design/human-interface-guidelines)
