//
//  LiveDatasource.swift
//  Fetch-Recipes
//
//  Created by Dev on 7/1/24.
//

import Foundation

class LiveDatasource: ApiDatasource {
    
    func call_GET_desserts() async throws -> Data {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func call_GET_meal(id: String) async throws -> Data {
        let urlId = id.trimmingCharacters(in: .whitespacesAndNewlines)
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(urlId)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
        
}
