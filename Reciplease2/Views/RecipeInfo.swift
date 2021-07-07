//
//  RecipeDetailed.swift
//  Reciplease2
//
//  Created by Naji Achkar on 04/05/2021.
//

import SwiftUI
import SafariServices
import CoreData

struct RecipeInfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = CoreDataManager.shared
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @State private var showSafari = false
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    let recipe: RecipeRepresentable
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    init(recipe: RecipeRepresentable) {
        self.recipe = recipe
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    var body: some View {
        GeometryReader { geo in
            VStack {
                ///////////////////////////////////////////// IMAGE ///////////////////////////////////////////////////////////////
                RemoteImage(url: recipe.image)
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.4, alignment: .center)
                Divider()
                //////////////////////////// SERVINGS AND COOKTIME //////////////////////////////////////////////////////
                HStack {
                    Spacer()
                    Image(systemName: "person.fill")
                    Text(String(recipe.servings)).bold()
                    Spacer()
                    Image(systemName: "clock")
                    Text(String(recipe.cookTime)).bold()
                    Spacer()
                    ////////////////////////////////////  DIRECTIONS BUTTON ////////////////////////////////////////////////////////////////////////
                    Button(action: { showSafari.toggle()
                    })  {
                        Text("DIRECTIONS")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.appGreen)
                            .cornerRadius(20)
                    }
                    Spacer()
                }
                Divider()
                //////////////////////////////////////////////// INGREDIENTS LIST ////////////////////////////////////////////////////////////
                Form {
                    List {
                        ForEach(0..<recipe.ingredients.count, id: \.self) { index in
                            Text(recipe.ingredients[index])
                        } } }
            }
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            .navigationBarTitle(recipe.label, displayMode: recipe.label.count <= 20 ? .large : .inline)
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            .navigationBarItems(trailing: Button(action: { didTapHeartButton() })  {
                Image(systemName: viewModel.isAlreadyInFavorite(name: recipe.label) ? "heart.fill" : "heart")
                    .foregroundColor(Color.red)
            })
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            .sheet(isPresented: $showSafari) {
                SafariView(url: URL(string: recipe.url)!)
            }
        }
    }
    ///////////////////////////////////////////// METHOD DIDTAPHEARTBUTTON ///////////////////////////////////////////////////////////////
    func didTapHeartButton() {
        if viewModel.isAlreadyInFavorite(name: recipe.label) {
            viewModel.removeFavorite(name: recipe.label)
            self.presentationMode.wrappedValue.dismiss()
            viewModel.checkFavorites()
        } else {
            viewModel.addFavorite(recipe: self.recipe)
            viewModel.fetchFavorites()
        }
    }
}
/////////////////////////////////// PREVIEW //////////////////////////////////////////////////////
struct RecipeInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeInfoView(recipe: RecipeRepresentable.sample)
    }
}











