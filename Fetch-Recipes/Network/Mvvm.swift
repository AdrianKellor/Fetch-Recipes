//
//  Mvvm.swift
//  Fetch
//
//  Created by Adrian on 12/3/22.
//

import Foundation

class Meal: Observable, Identifiable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    init?(data: [String:Any]?) {
        guard let values = data else {
            return nil
        }
        
        strMeal = values["strMeal"] as? String
        strMealThumb = values["strMealThumb"] as? String
        idMeal = values["idMeal"] as? String
    }
}

struct Ingredient: Identifiable {

    let id = UUID()
    let measurement: String?
    let description: String?
    
    init?(measurement: String?, description: String?) {
        if measurement == nil, description == nil {
            return nil
        }
        self.measurement = measurement
        self.description = description
    }
}

class Recipe {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let ingredients: [Ingredient]
    
    init?(data: [String:Any]?) {
        guard let values = data else {
            return nil
        }
        
        idMeal = values["idMeal"] as? String
        strMeal = values["strMeal"] as? String
        strInstructions = values["strInstructions"] as? String
        
        var workIngredients = [Ingredient]()
        for num in 1...20 {
            if let ingredient = Ingredient(measurement: values["strMeasure\(num)"] as? String,
                                           description: values["strIngredient\(num)"] as? String) {
                workIngredients.append(ingredient)
            }
        }
        ingredients = workIngredients
    }
    
}
