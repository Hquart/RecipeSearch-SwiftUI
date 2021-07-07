//
//  CookingListView.swift
//  Reciplease2
//
//  Created by Naji Achkar on 24/04/2021.
//

import SwiftUI

struct CookingListView: View {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: - PROPERTIES
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @ObservedObject var recipeService = RecipeService()
    
    @State private var newIngredient: String = ""
    @State private var isEditing: Bool = false
    @State private var isSearchingResults: Bool = false
    @State private var isShowingResults: Bool = false
    //////////////////////////////////////////////////////////////////////////
    //  MARK: - BODY
    //////////////////////////////////////////////////////////////////////////
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack(alignment: .center, spacing: 20, content: {
                    Divider()
                    //////////////////////////////////////////////////////////////////////////
                    //  MARK: - IMAGE AND LABEL
                    //////////////////////////////////////////////////////////////////////////
                    Image("chief")
                    Text("What's in your kitchen ?")
                        .italic()
                        .font(.headline)
                    //////////////////////////////////////////////////////////////////////////
                    //  MARK: - TEXTFIELD
                    //////////////////////////////////////////////////////////////////////////
                    HStack {
                        TextField(" New Ingredient", text: $newIngredient) { isEditing in
                            self.isEditing = isEditing
                            if isEditing == true {
                                newIngredient = "" }
                        }
                        onCommit: {
                            self.isEditing = false
                            hideKeyboard()
                            recipeService.addIngredientToList(input: newIngredient)
                        }
                        .padding()
                        .frame(width: 250, height: 30, alignment: .center)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.appGreen, lineWidth: 2)
                                .multilineTextAlignment(.leading))
                        //////////////////////////////////////////////////////////////////////////
                        //  MARK: - TEXTFIELD BUTTON
                        //////////////////////////////////////////////////////////////////////////
                        Button(action: { recipeService.addIngredientToList(input: newIngredient) })  {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(.appGreen)
                        } }
                    //////////////////////////////////////////////////////////////////////////
                    //  MARK: - COOKING LIST
                    //////////////////////////////////////////////////////////////////////////
                    List {
                        ForEach(recipeService.cookingList, id: \.self) { ingredient in
                            HStack {
                                Spacer()
                            Text(ingredient).italic().font(.title)
                                .foregroundColor(.appGreen)
                                .bold()
                                .lineLimit(nil)
                                .multilineTextAlignment(.center)
                                Spacer()
                            }
                        }
                        .onDelete(perform: recipeService.deleteIngredient)
                    }
                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.45, alignment: .center)
                    .opacity(recipeService.cookingList.isEmpty ? 0.6 : 0.8)
                    .background(Image("cookingTable")
                                    .resizable()
                                    .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.45, alignment: .center))
                    //////////////////////////////////////////////////////////////////////////
                    //  MARK: - SEARCHRECIPE BUTTON
                    //////////////////////////////////////////////////////////////////////////
                    NavigationLink(destination: SearchResultsView(recipesData: recipeService.recipesData),
                                   isActive: $isShowingResults) { EmptyView() }
                    Button(action: { didTapSearchRecipeButton() }) {
                        ZStack {
                            Text("RECIPE PLEASE")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.appGreen)
                                .cornerRadius(30)
                                .zIndex(isSearchingResults ? 0 : 1)
                            ProgressView()
                                .zIndex(isSearchingResults ? 1 : 0)
                        }
                    }
                })
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                .navigationTitle("Cooking List")
                .navigationBarItems(trailing:  Button("Clear List") { recipeService.cookingList.removeAll() })
                .alert(isPresented: $recipeService.showAlert) {
                    Alert(title: Text("Check your Cooking List"), message: Text("The list must contain 1 to 5 ingredients, each one specific"),
                          dismissButton: .default(Text("OK")))
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
    //////////////////////////////////////////////////////////////////////////
    //  MARK: - METHOD
    //////////////////////////////////////////////////////////////////////////
    func didTapSearchRecipeButton() {
        guard !recipeService.cookingList.isEmpty else {
            recipeService.showAlert.toggle()
            return }
        recipeService.getRecipes()
        sleep(2)
        isShowingResults = true
    }
}
//////////////////////////////////////////////////////////////////////////
//  MARK: - PREVIEW
//////////////////////////////////////////////////////////////////////////
struct CookingListView_Previews: PreviewProvider {
    static var model = RecipeService()
    static var previews: some View {
        CookingListView(recipeService: RecipeService())
    }
}




