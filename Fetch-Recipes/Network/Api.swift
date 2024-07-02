//
//  Api.swift
//  Fetch-Recipes
//
//  Created by Dev on 7/1/24.
//

import Foundation

class Api {
    
    var apiDatasource: ApiDatasource
    
    init(apiDatasource: ApiDatasource) {
        self.apiDatasource = apiDatasource
    }
    
    func GET_desserts() async throws -> [Meal] {
        do {
            
            let data = try await apiDatasource.call_GET_desserts()
            
            var meals = [Meal]()
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let jsonMeals = json["meals"] as? [[String: Any]] {
                jsonMeals.forEach { jsonMeal in
                    if let meal = Meal(data: jsonMeal) {
                        meals.append(meal)
                    }
                }
            }
            return meals
        } catch {
            print(String(describing: error))
            throw error
        }
    }
    
    func GET_meal(id: String) async throws -> Recipe? {
        
        do {

            let data = try await apiDatasource.call_GET_meal(id: id)
            
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let meal = json["meals"] as? [Any],
               let recipe = Recipe(data: meal[0] as? [String: Any]) {
                return recipe
            } else {
                return nil
            }

        } catch {
            print(String(describing: error))
            throw error
        }
    }
    
    
}
