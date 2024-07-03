//
//  Network.swift
//  Fetch
//
//  Created by Adrian on 12/3/22.
//

import Foundation

protocol ApiDatasource {
    
    func call_GET_desserts() async throws -> Data
    func call_GET_meal(id: String) async throws -> Data
}


