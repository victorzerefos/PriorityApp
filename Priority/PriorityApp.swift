//
//  PriorityApp.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import SwiftUI

@main
struct PriorityApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
