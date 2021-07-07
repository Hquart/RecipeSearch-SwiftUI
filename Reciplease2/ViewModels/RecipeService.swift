//
//  CookingListViewModel.swift
//  Reciplease2
//
//  Created by Naji Achkar on 25/04/2021.
//

import Foundation
import SwiftUI
import Combine
import CoreData

final class RecipeService: ObservableObject  {
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: - PROPERTIES
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    @Published var recipesData = RecipesData()
    @Published var cookingList: [String] = []
    @Published var showAlert: Bool = false
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    private var cancellable: AnyCancellable?
    private let baseURL = "https://api.edamam.com/search"
    private var parameters: [String: String] {
        return  ["q": cookingList.joined(separator: ","),
                 "app_id": APIKeys.app_id,
                 "app_key": APIKeys.app_key,]
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //  MARK: - METHODS
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRecipesData(baseURL: String, parameters: [String : String]) -> AnyPublisher<RecipesData, Error> {
        guard var components = URLComponents(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        components.setQueryItems(with: parameters)
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher() }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: RecipesData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getRecipes()  {
        cancellable = getRecipesData(baseURL: baseURL, parameters: parameters)
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.recipesData)}
            .sink(receiveValue: { data in
                self.recipesData = data
            })
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func addIngredientToList(input: String) {
        guard !cookingList.contains(input), cookingList.count < 5 else {
            showAlert.toggle()
            return }
        cookingList.append(input)
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func deleteIngredient(at offsets: IndexSet) {
        cookingList.remove(atOffsets: offsets)
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

