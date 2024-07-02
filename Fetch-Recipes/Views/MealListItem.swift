//
//  RecipeListItem.swift
//  Fetch-Recipes
//
//  Created by Dev on 6/30/24.
//

import SwiftUI

struct MealListItem: View {
    
    var viewModel: MealListItem.ViewModel
    
    init(meal: Meal) {
        self.viewModel = MealListItem.ViewModel(meal: meal)
    }
    
    var body: some View {
        VStack(spacing: 36, content: {
            HStack {
                Group {
                    Text("Image")
                        .frame(width: 64, height: 64)
                }
                Group {
                    Text(viewModel.meal.strMeal ?? "")
                }
            }
        })
        .frame(height: 64)
    }
}

extension MealListItem {
    
    final class ViewModel: ObservableObject {
        let meal: Meal
        init(meal: Meal) {
            self.meal = meal
        }
    }
}

struct MealListItem_Preview: PreviewProvider {
//    static let recipe = Recipe(data: ["strInstructions": "Instructions go here",
//                                      "strMeal": "Clam Chowder",
//                                      "strMeasure1": "1 tsp",
//                                      "strIngredient1": "Clams"])
//
//    let idMeal: String?
//    let strMeal: String?
//    let strInstructions: String?
//    let ingredients: [Ingredient]
//
//    static var previews: some View {
//        MealListItem(viewModel: MealListItem.ViewModel(recipe: recipe!))
//    }
  
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?

    
    static let meal = Meal (data: ["strMeal": "Clam Chowder",
                                   "strMealThumb": "",
                                   "idMeal": "123"])

    static var previews: some View {
        MealListItem(meal: meal!)
    }
}
