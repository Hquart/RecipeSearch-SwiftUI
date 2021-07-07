//
//  Reciplease2App.swift
//  Reciplease2
//
//  Created by Naji Achkar on 24/04/2021.
//

import SwiftUI
import CoreData

@main
struct Reciplease2App: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                CookingListView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Cooking List")
                    }
                    
                FavoritesView()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("favorites")
                    }
            }
    }
    }
}
            
