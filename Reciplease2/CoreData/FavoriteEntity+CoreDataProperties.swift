//
//  FavoriteEntity+CoreDataProperties.swift
//  Reciplease2
//
//  Created by Naji Achkar on 26/05/2021.
//
//

import Foundation
import CoreData


extension FavoriteEntity: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteEntity> {
        return NSFetchRequest<FavoriteEntity>(entityName: "FavoriteEntity")
    }

    @NSManaged public var cookTime: Int16
    @NSManaged public var servings: Int16
    @NSManaged public var url: String?
    @NSManaged public var name: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var ingredients: NSObject?
    @NSManaged public var imageData: Data?

    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // Wrapped properties avoid dealing with optionnals from CoreData:
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    public var wrappedUrl: String {
        return url ?? "recipe's URL"
    }
    public var wrappedName: String {
        return name ?? "recipe's Name"
    }
    public var wrappedImageUrl: String {
        return imageUrl ?? "image URL"
    }
    
    public var wrappedIngredients: [String] {
        return ingredients as? [String] ?? []
    }
    public var ingredientsJoined: String {
        if let array = ingredients as? [String] {
        return array.joined()
    }
        return "ingredients"
    }
}

