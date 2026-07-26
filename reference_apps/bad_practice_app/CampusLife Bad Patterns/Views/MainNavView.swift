import SwiftUI

struct MainNavView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            

            // Inhaltsbereich, der je nach "Tab" wechselt
            VStack {
                if selectedTab == 0 {
                    NewsView()
                } else if selectedTab == 1 {
                    EventView()
                } else {
                    InfoView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // PATTERN 8 & 2: Footer & Tab-Leiste
            // BARRIERE: Selbstgebaute Tab-Leiste ohne semantische "TabBar"-Rolle. Screenreader wissen nicht, dass das eine Navigation ist
            // BARRIERE: Fixe Höhe kollidiert mit dem Home-Indicator unten (keine Safe Area)
            HStack {
                Spacer()
                
                // BARRIERE: Kein nativer Button, sondern nur ein Image mit onTapGesture. Es gibt kein Screenreader-Feedback (wie "Taste") und keine Text-Labels
                // BARRIERE: Touch-Target ist zu klein
                Image(systemName: "newspaper.fill")
                    .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    .onTapGesture { selectedTab = 0 }
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    .onTapGesture { selectedTab = 1 }
                
                Spacer()
                
                Image(systemName: "info.circle.fill")
                    .foregroundColor(selectedTab == 2 ? .blue : .gray)
                    .onTapGesture { selectedTab = 2 }
                
                Spacer()
            }
            .frame(height: 50)
            .background(Color(.systemGray6))
        }
        // BARRIERE: Ignoriert die untere Safe-Area absichtlich
        .ignoresSafeArea(.all, edges: .bottom)
        
        // PATTERN 8: Starr erzwungene Orientierung
        // BARRIERE: Verhindert, dass Nutzer das Gerät drehen können
        .onAppear {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
}

#Preview {
    MainNavView()
}
