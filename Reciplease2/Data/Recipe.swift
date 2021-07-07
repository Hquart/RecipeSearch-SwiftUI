//
//  Recipe.swift
//  Reciplease2
//
//  Created by Naji Achkar on 25/04/2021.
//


import Foundation
import Combine
import SwiftUI
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Types used for Data decoding from Edamam API
////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct RecipesData: Codable {
    let hits: [Hit]
    
    init(hits: [Hit] = []) {
        self.hits = hits
    }
}
//////////////////////////////////////////////////////
struct Hit: Codable  {
    let recipe: Recipe
}
//////////////////////////////////////////////////////
struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    let totalTime: Int
    let yield: Int
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Type used to represent Recipe in RecipeInfoView and to save recipe in CoreData Favorites
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct RecipeRepresentable {

    var label: String
    var image: String
    var url: String
    var ingredients: [String]
    var servings: Int
    var cookTime: Int
    var isFavorite: Bool
    //////////////////////////////////////////////////////
    init(label: String, image: String, url: String, ingredients: [String], servings: Int, cookTime: Int, isFavorite: Bool) {
        self.label = label
        self.image = image
        self.url = url
        self.ingredients = ingredients
        self.servings = servings
        self.cookTime = cookTime
        self.isFavorite = isFavorite
    }
    ///////////////////  PREVIEW SAMPLE /////////////////////////////////////////////////////
    static var sample = RecipeRepresentable(label: "pizza",
                                            image: "pizza",
                                            url: "",
                                            ingredients: ["pate", "sauce", "fromage"],
                                            servings: 2,
                                            cookTime: 25,
                                            isFavorite: false)
}




