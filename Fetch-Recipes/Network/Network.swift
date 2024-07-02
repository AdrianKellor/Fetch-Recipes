//
//  Network.swift
//  Fetch
//
//  Created by Adrian on 12/3/22.
//

import Foundation
import UIKit

protocol ApiDatasource {
    func GET_desserts() async throws -> [Meal]
    func GET_meal(id: String) async throws -> Recipe?
}

class LiveApi: ApiDatasource {
    
    func GET_desserts() async throws -> [Meal] {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

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
        
        let urlId = id.trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(urlId)")!

        do {

            let (data, _) = try await URLSession.shared.data(from: url)

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
