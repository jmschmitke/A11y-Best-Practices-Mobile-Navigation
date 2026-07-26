//
//  CampusLife_Good_PatternsApp.swift
//  CampusLife Good Patterns
//
//  Created by Jennifer-Michelle Schmitke on 22.07.26.
//

import SwiftUI
import SwiftData

@main
struct CampusLife_Good_PatternsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
