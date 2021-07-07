//
//  RecipesDataView.swift
//  Reciplease2
//
//  Created by Naji Achkar on 26/04/2021.
//

import SwiftUI
import CoreData

struct SearchResultsView: View {
    
    var recipesData: RecipesData
    //////////////////////////////////////////////////////////////////////
    init(recipesData: RecipesData) {
        self.recipesData = recipesData
    }
    //////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 20, content: {
                ////////////////////////////////////////////////////  IMAGE & LABEL ///////////////////////////////////////////////////////
                Image("chief")
                Text(recipesData.hits.count == 0 ? "I couldn't find any recipe for you" : "Here's what I found")
                    .italic()
                    .font(.headline)
                Divider()
                //////////////////////////////////////////////////// RECIPE ROWS LIST ///////////////////////////////////////////////////////
                List {
                    ForEach(0..<recipesData.hits.count, id: \.self) { index in
                        
                        NavigationLink(destination: RecipeInfoView(recipe: mapToRecipeRepresentable(input: recipesData, row: index))) {
                                        
                            RecipeRow(recipe: mapToRecipeRepresentable(input: recipesData, row: index))
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.25, alignment: .center)
                        }
                    }
                }
            })
            .navigationTitle("Recipes")
        }
    }
    ////////////////////////////////////////////////////  MAP METHOD  //////////////////////////////////////////////////////
    func mapToRecipeRepresentable(input: RecipesData, row: Int) -> RecipeRepresentable {
        let recipe = RecipeRepresentable (label: input.hits[row].recipe.label,
                                          image: input.hits[row].recipe.image,
                                          url: input.hits[row].recipe.url,
                                          ingredients: input.hits[row].recipe.ingredientLines,
                                          servings: input.hits[row].recipe.yield,
                                          cookTime: input.hits[row].recipe.totalTime,
                                          isFavorite: false)
        return recipe
    }
}
////////////////////////////////////   PREVIEW  //////////////////////////////////
struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(recipesData: Bundle.main.decode("RecipesData.json"))
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//We used this extension to provide data to the preview from "RecipesData.json" file
extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        return loaded
    }
}

