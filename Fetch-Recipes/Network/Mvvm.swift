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
        
        strMeal = (values["strMeal"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        strMealThumb = (values["strMealThumb"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        idMeal = (values["idMeal"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

struct Ingredient: Identifiable {

    let id = UUID()
    let measurement: String?
    let description: String?
    
    init?(measurement: String?, description: String?) {
        let trimmedMeasurment = measurement?.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedDescription = description?.trimmingCharacters(in: .whitespacesAndNewlines)
        if (trimmedMeasurment ?? "").isEmpty, (trimmedDescription ?? "").isEmpty {
            return nil
        }
        self.measurement = trimmedMeasurment
        self.description = trimmedDescription
    }
}


class Recipe {
    let idMeal: String?
    let strMeal: String?
    let strInstructions: String?
    let strMealThumb: String?
    let ingredients: [Ingredient]

    init?(data: [String:Any]?) {
        guard let values = data else {
            return nil
        }
        
        idMeal = values["idMeal"] as? String
        strMeal = (values["strMeal"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        strInstructions = (values["strInstructions"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)
        strMealThumb = (values["strMealThumb"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines)

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
