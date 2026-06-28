# 01: Search

Selected Language: English

Other Languages: [German](01_search_de.md)

---

## 1. Context and Problem Statement

### Context of Use
The search function is one of the central navigation elements in mobile apps. It provides users with direct, targeted access to specific content, products, or features without having to navigate through complex hierarchical menu structures. In a mobile context, a search typically consists of a text input field (*TextField*), an element to clear the text (*Clear Button*), a cancel function (*Cancel Button*), and a dynamic list of results.

### Typical Barriers in Practice
* **Missing semantic markup:** Without an explicit, programmatically linked label or an accessible name, the input field is announced by assistive technologies merely as an unlabelled text field. Users with visual impairments therefore cannot identify the purpose of the field.
* **Focus loss and disorientation:** When the search field is activated, many apps dynamically open new views (e.g., search suggestions) or the software keyboard appears. If the accessibility focus is not explicitly managed at this moment, the screen reader jumps to an unpredictable location. This leads to cognitive disorientation.
* **Insufficient touch targets:** The integrated "Clear" button (X) and the "Cancel" button are often visually designed to be very delicate. For people with motor impairments, these essential control elements are difficult or impossible to activate precisely.
* **Missing feedback for live results:** If search results change dynamically during input, the focus usually remains in the text field. Without auditory feedback, the updating of the results list goes unnoticed by blind and visually impaired users.

---

## 2. Relevant Guidelines and Standards

The following table shows the relationship between the technical success criteria of **WCAG 2.2** and the regulations within Chapter 11 of **EN 301 549**.

| Accessibility Requirement | WCAG 2.2 Criterion | EN 301 549 | Relevance to the Search Pattern |
| :--- | :--- | :--- | :--- |
| **Information & Relationships** | 1.3.1 Info and Relationships | 11.1.3.1 | Clear programmatic structuring of the relationship to other fields. |
| **Meaningful Sequence** | 1.3.2 Meaningful Sequence | 11.1.3.2 | Logical, linear reading flow from the search field to the results. |
| **Contrast (Minimum)** | 1.4.3 Contrast (Minimum) | 11.1.4.3 | Text and placeholders must stand out sharply from the background. |
| **Keyboard Accessible** | 2.1.1 Keyboard | 11.2.1.1 | Full functionality when using external hardware keyboards. |
| **Focus Order** | 2.4.3 Focus Order | 11.2.4.3 | The focus path must guide logically through the search interface. |
| **Focus Visible** | 2.4.7 Focus Visible | 11.2.4.7 | Clear visual border around the field during keyboard navigation. |
| **On Focus** | 3.2.1 On Focus | 11.3.2.1 | Mere focusing must not trigger an unexpected change of context. |
| **On Input** | 3.2.2 On Input | 11.3.2.2 | Text input must not change the app structure unannounced. |
| **Labels or Instructions** | 3.3.2 Labels or Instructions | 11.3.3.2 | Provision of clear, permanent instructions (e.g., search context). |
| **Name, Role, Value** | 4.1.2 Name, Role, Value | 11.4.1.2 | Unambiguous assignment of name, role, and status. |
| **Assistive Technologies** | - | 11.5.2.4 / 11.5.2.5 | Correct transmission of control element types to the Accessibility API. |

---

## 3. Design Specifications (UI/UX)

### Visual Design and Contrasts
* **More than just icons:** A mere magnifying glass icon is not sufficient for accessibility, as it poses cognitive barriers. The search field *must* be permanently defined by a readable text label (e.g., "Search") or a clear placeholder (e.g., "Search catalog...").
* **Contrast ratios:** * The entered text and the placeholder text must have a contrast ratio of at least **4.5:1** against the direct background of the search field.
  * The visual boundary (border/background area) of the search field must have a contrast ratio of at least **3:1** against the surrounding screen background to be recognizable as an interactive element.

### Interaction Design and Touch Targets
* **44pt minimum size:** The input field must have a vertical minimum height of **44 points**.
* **Embedded controls:** The "Clear" button (X) placed within the text field and the primary "Cancel" button next to it must have an accessible click and touch area of at least **44 x 44 points**, regardless of the actual visual icon size.
* **System-compliant keyboard control:** When the search field is activated, the correct virtual keyboard type must be programmatically invoked. The action key on the bottom right of the software keyboard must be configured as "Search" instead of the standard line break ("Return").

### Recommended Focus Order (VoiceOver / Keyboard)
1. **Focus 1:** The search field (TextField). Voice output: *"Search, text field, double tap to edit. [Placeholder text]."*
2. **Focus 2 (Conditional):** The "Clear" button (only becomes active once text is entered). Voice output: *"Clear text, button."*
3. **Focus 3:** The dynamically loaded list of search results or suggestions, navigable linearly from top to bottom.

---

## 4. Implementation (SwiftUI)

### Good Pattern (Best Practice)
This example shows a recommended, accessible implementation of a search bar that uses native components according to the Apple Human Interface Guidelines.
```swift
import SwiftUI

struct GoodNativeSearchView: View {
    @State private var searchText = ""
    @State private var allItems = ["Apple", "Banana", "Cherry"]
    
    var filteredItems: [String] {
        searchText.isEmpty ? allItems : allItems.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredItems, id: \.self) { item in
                    Text(item)
                }
            }
            .navigationTitle("Catalog")
            
            // BEST PRACTICE: The native modifier automatically fulfills relevant guidelines.
            // Touch targets (44pt) and focus management are guaranteed by the system.
            // Note: The system automatically uses the 'prompt' parameter ("Search catalog...") 
            // as an accessibility label for VoiceOver. A manual label is not necessary.
            .searchable(text: $searchText, prompt: "Search catalog...")
        }
    }
}
```

### Bad Pattern (Bad Practice)
This example shows a typically flawed implementation of a custom search bar. It ignores central guidelines regarding semantics, keyboard control, and minimum sizes for touch targets.
```swift
import SwiftUI

struct BadSearchView: View {
    @State private var searchText = ""
    @State private var items = ["Apple", "Banana", "Cherry"]
    
    var body: some View {
        VStack {
            // ERROR 1: No semantic grouping. VoiceOver reads the magnifying glass, text field, 
            // and clear button as completely separate, disconnected elements.
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                // ERROR 2: No explicit accessibility label.
                // ERROR 3: Wrong keyboard type. "Return" is shown by default instead of "Search".
                TextField("Search", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                
                if !searchText.isEmpty {
                    // ERROR 4: Touch target is much too small (approx. 15x15pt instead of the required 44x44pt).
                    // ERROR 5: onTapGesture instead of Button. VoiceOver does not recognize it as a clickable control.
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            searchText = ""
                        }
                }
            }
            .padding(8)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding()
            
            List {
                ForEach(items.filter { searchText.isEmpty ? true : $0.contains(searchText) }, id: \.self) { item in
                    Text(item)
                }
            }
        }
    }
}
```
