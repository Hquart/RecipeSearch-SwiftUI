//
//  Reciplease2App.swift
//  Reciplease2
//
//  Created by Naji Achkar on 24/04/2021.
//

import SwiftUI

@main
struct Reciplease2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
