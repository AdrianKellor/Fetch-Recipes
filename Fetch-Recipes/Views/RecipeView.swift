//
//  RecipeView.swift
//  Fetch-Recipes
//
//  Created by Dev on 6/30/24.
//

import SwiftUI

struct RecipeView: View {
    
    @StateObject var viewModel: RecipeView.ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                Text("Image")
                Text(viewModel.recipe?.strMeal ?? "")
                Text(viewModel.recipe?.strInstructions ?? "")
                
                VStack(alignment:.leading) {
                    ForEach(viewModel.recipe?.ingredients ?? []) { Ingredient in
                        HStack(alignment: .top) {
                            Text(Ingredient.measurement ?? "").frame(width: 100, alignment: .leading)
                            Text(Ingredient.description ?? "").frame(alignment: .leading)
                        }
                    }
                }
                
            })
        }
        .onAppear() {
            Task {
                await viewModel.getRecipe()
            }
        }
    }
}

extension RecipeView {
    
    @MainActor
    final class ViewModel: ObservableObject {

        let api: ApiDatasource
        var mealId: String?
        @Published var recipe: Recipe?
        @Published var errorText: String?
        
        init(meal: Meal, api: ApiDatasource) {
            self.api = api
            if let id = meal.idMeal {
                mealId = id
            } else {
                errorText = "No meal id"
            }
        }
        
        func getRecipe() async {
            if let id = mealId {
                do {
                    if let newRecipe = try await api.GET_meal(id: id) {
                        recipe = newRecipe
                    } else {
                        errorText = "No recipe returned"
                    }
                } catch {
                    errorText = error.localizedDescription
                }

            }
        }
    }
}

struct RecipeView_Preview: PreviewProvider {

    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    static let meal = Meal (data: ["strMeal": "Clam Chowder",
                                   "strMealThumb": "",
                                   "idMeal": "123"])

    static var previews: some View {
        RecipeView(viewModel: RecipeView.ViewModel(meal: meal!, api: MockAPI()))
    }
}

