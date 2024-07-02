//
//  RecipeView.swift
//  Fetch-Recipes
//
//  Created by Dev on 6/30/24.
//

import SwiftUI
import Kingfisher

struct RecipeView: View {
    
    @StateObject var viewModel: RecipeView.ViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                Text(viewModel.recipe?.strMeal ?? "")
                    .bold()

                if let url = viewModel.recipe?.strMealThumb {
                    KFImage(URL(string: url))
                        .resizable()
                        .frame(width: 200, height: 200)
                }
                
                Text("Ingredients:")
                VStack(alignment:.leading) {
                    ForEach(viewModel.recipe?.ingredients ?? []) { Ingredient in
                        HStack(alignment: .top) {
                            Text(Ingredient.measurement ?? "").frame(width: 100, alignment: .leading)
                            Text(Ingredient.description ?? "").frame(alignment: .leading)
                        }
                    }
                }

                Text("Instructions:")
                
                Text(viewModel.recipe?.strInstructions ?? "")
                
            })
        }
        .padding(EdgeInsets(top: 10, leading: 24, bottom: 10, trailing: 24 ))
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

        let api: Api
        var mealId: String?
        @Published var recipe: Recipe?
        @Published var errorText: String?
        
        init(meal: Meal, api: Api) {
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

    static let mockApi = Api(apiDatasource: MockDatasource())
    static let meal = Meal (data: ["strMeal": "Apam balik",
                                   "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                                   "idMeal": "53049"])

    static var previews: some View {
        
        let viewModel = RecipeView.ViewModel(meal: meal!, api: mockApi)
        
        RecipeView(viewModel: viewModel)
            .onAppear() {
                Task {
                    viewModel.recipe = try await mockApi.GET_meal(id: "anyId")
                }
            }
    }
}

