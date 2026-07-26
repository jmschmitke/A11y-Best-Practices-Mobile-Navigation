import SwiftUI

struct MainNavView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        
        // Native Implementierung mit TabView()
        TabView(selection: $selectedTab) {
            
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper.fill")
                }
                .tag(0)
            
            EventView()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(1)
            
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle.fill")
                }
                .tag(2)
        }
        .tint(.blue)
    }
}

#Preview {
    MainNavView()
}
