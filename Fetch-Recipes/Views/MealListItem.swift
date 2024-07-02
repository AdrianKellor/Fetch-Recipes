//
//  RecipeListItem.swift
//  Fetch-Recipes
//
//  Created by Dev on 6/30/24.
//

import SwiftUI
import Kingfisher

struct MealListItem: View {
    
    var viewModel: MealListItem.ViewModel
    
    init(meal: Meal) {
        self.viewModel = MealListItem.ViewModel(meal: meal)
    }
    
    var body: some View {
        VStack(spacing: 4, content: {
            HStack {
                if let url = viewModel.meal.strMealThumb {
                    KFImage(URL(string: url)!)
                        .resizable()
                        .frame(width: 48, height: 48)
                } else {
                    Spacer()
                }
                Text(viewModel.meal.strMeal ?? "")
            }
        })
        .frame(height: 48)
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
  
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?

    
    static let meal = Meal (data: ["strMeal": "Apple & Blackberry Crumble",
                                   "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
                                   "idMeal": "52893"])

    
    static var previews: some View {
        MealListItem(meal: meal!)
    }
}
