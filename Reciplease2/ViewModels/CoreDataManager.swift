////
////  CoreDataManager.swift
////  Reciplease2
////
////  Created by Naji Achkar on 09/05/2021.
////
import Foundation
import CoreData
import SwiftUI
import UIKit

class CoreDataManager: ObservableObject {
    
    let container: NSPersistentContainer
    
//    static var preview: CoreDataManager
    static let shared = CoreDataManager()
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Published var favorites = [FavoriteEntity]()
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    var moc: NSManagedObjectContext {
        return container.viewContext
    }
    ////////////////////////////////////////////// SHARED INIT ////////////////////////////////////////////////////////////
    init() {
        container = NSPersistentContainer(name: "RecipesContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
        fetchFavorites()
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    func fetchFavorites() {
        let request = NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
        do {
            favorites = try moc.fetch(request)
            saveData()
        } catch let error {
            print("error fetching. \(error)")
        }
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addFavorite(recipe: RecipeRepresentable) {
        let newFavorite = FavoriteEntity(context: moc)
        newFavorite.name = recipe.label
        newFavorite.imageUrl = recipe.image
        newFavorite.cookTime = Int16(recipe.cookTime)
        newFavorite.url = recipe.url
        newFavorite.servings = Int16(recipe.servings)
        newFavorite.ingredients = recipe.ingredients as NSObject
        saveData()
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    func isAlreadyInFavorite(name: String) -> Bool {
           let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
           request.predicate = NSPredicate(format: "name == %@", name)
           guard let recipeSearch = try? moc.fetch(request) else { return false }
           if recipeSearch.isEmpty { return false }
           return true
       }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    func removeFavorite(name: String)  {
        let request: NSFetchRequest<FavoriteEntity> = FavoriteEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        guard let recipes = try? moc.fetch(request) else { return }
        recipes.forEach { moc.delete($0) }
        saveData()
        fetchFavorites()
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////
    func saveData() {
        do { try moc.save()
        } catch {
            moc.rollback()
            print("could not save to coreData")
        }
    }
    //////////////////// DEBUG FUNC /////////////////////////////
    func checkFavorites() {
        var array: [String] = []
        for fav in favorites {
            array.append(fav.name ?? "")
        }
        debugPrint("\(favorites.count) recipe: \(array)")
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////  
}

