//
//  FavoritesView.swift
//  Reciplease2
//
//  Created by Naji Achkar on 25/04/2021.
//

import SwiftUI
import CoreData
import UIKit

struct FavoritesView: View {
    
    @StateObject private var viewModel = CoreDataManager.shared
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack {
                    List {
                        ForEach(0..<viewModel.favorites.count, id: \.self) { index in
                            NavigationLink(destination: RecipeInfoView(recipe: RecipeRepresentable(label: viewModel.favorites[index].wrappedName,
                                                                                               image: viewModel.favorites[index].wrappedImageUrl,
                                                                                               url: viewModel.favorites[index].wrappedUrl,
                                                                                               ingredients: viewModel.favorites[index].wrappedIngredients,
                                                                                               servings: Int(viewModel.favorites[index].servings),
                                                                                               cookTime: Int(viewModel.favorites[index].cookTime),
                                                                                               isFavorite: true))) {
                                VStack {
                                    ////////////////////////////  LABEL //////////////////////////////////////////////////////
                                    Text(viewModel.favorites[index].wrappedName)
                                        .frame(width: 380, height: 40, alignment: .center)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .background(Color.appGreen)
                                        .border(Color.black)
                                    HStack {
                                        ////////////////////////////  IMAGE  //////////////////////////////////////////////////////
                                        buildImage(url: viewModel.favorites[index].wrappedImageUrl)
                                            .resizable()
                                            .scaledToFit()
                                        VStack(alignment: .leading) {
                                            //////////////////////////// SERVINGS AND COOKTIME //////////////////////////////////////////////////////
                                            HStack {
                                                Spacer()
                                                Image(systemName: "person.fill")
                                                Text(String(viewModel.favorites[index].servings)).bold()
                                                Spacer()
                                                Image(systemName: "clock")
                                                Text(String(viewModel.favorites[index].cookTime)).bold()
                                                Spacer()
                                            }
                                            ////////////////////////////  INGREDIENTS  //////////////////////////////////////////////////////
                                            Text(viewModel.favorites[index].ingredientsJoined)
                                                .font(.subheadline)
                                                .multilineTextAlignment(.leading)
                                                .padding()
                                                .frame(width: 280, height: 80, alignment: .leading)
                                        }
                                    }
                                    Spacer()
                                }
                                .frame(width: geo.size.width * 0.9, height: geo.size.height * 0.25, alignment: .center)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                let favoriteToRemove = viewModel.favorites[index]
                                viewModel.moc.delete(favoriteToRemove)
                                viewModel.fetchFavorites()
                            }
                        })
                    }
                }
                .onAppear(perform: {
                    viewModel.fetchFavorites()
                    viewModel.checkFavorites()
                })
                .navigationBarTitle("Favorites", displayMode: .large)
                .toolbar {
                    EditButton()
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func buildImage(url: String) -> Image {
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                if let img = UIImage(data: data) {
                    return Image(uiImage: img)
                }
            }
        }
        return Image("placeholder")
    }
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////
struct FavoritesView_Previews: PreviewProvider {
  
    static var previews: some View {
        FavoritesView()
    }
}


                                



