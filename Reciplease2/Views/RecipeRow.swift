//
//  RecipeRow.swift
//  Reciplease2
//
//  Created by Naji Achkar on 26/04/2021.
//

import SwiftUI
import CoreData

struct RecipeRow: View {
    
    @State private var recipe: RecipeRepresentable
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init(recipe: RecipeRepresentable) {
        self.recipe = recipe
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        VStack {
            ////////////////////////////  LABEL //////////////////////////////////////////////////////
            Text(recipe.label)
                .frame(width: 380, height: 40, alignment: .center)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.appGreen)
                .border(Color.black)
            HStack {
                ////////////////////////////  IMAGE  //////////////////////////////////////////////////////
                RemoteImage(url: recipe.image)
                    .scaledToFit()
                    .frame(width: 100,height:100)
                VStack(alignment: .leading) {
                    //////////////////////////// SERVINGS AND COOKTIME //////////////////////////////////////////////////////
                    HStack {
                        Spacer()
                        Image(systemName: "person.fill")
                        Text(String(recipe.servings)).bold()
                        Spacer()
                        Image(systemName: "clock")
                        Text(String(recipe.cookTime)).bold()
                        Spacer()
                    }
                    ////////////////////////////  INGREDIENTS  //////////////////////////////////////////////////////
                    Text(recipe.ingredients.joined(separator: ","))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(width: 280, height: 80, alignment: .leading)
                }
            }
            Spacer()
        }
    }
}
//////////////////////////// PREVIEW //////////////////////////////////////////////////////
struct RecipeRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            RecipeRow(recipe:  RecipeRepresentable.sample)
        }
    }
}




