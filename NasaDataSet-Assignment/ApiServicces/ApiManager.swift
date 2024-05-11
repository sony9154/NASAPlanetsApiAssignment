//
//  ApiManager.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import Foundation

enum APIError: Error {
  case invalidURL
  case unableToComplete
  case invalidResponse
  case invalidData
  case decodingError
}

class ApiManager: NSObject {
    static let shared = ApiManager()

    static let planetsURL = URL(string: "")

    func fetchPlanets() async throws -> [Planet] {
        guard let url = ApiManager.planetsURL else { return [] }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        do {
            let decodedResponse = try JSONDecoder().decode([Planet].self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decodingError
        }
    }
    
    func fetchPlantsFromLocal() async throws -> [Planet] {
        if let url = Bundle.main.url(forResource: "apod", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedResponse = try JSONDecoder().decode([Planet].self, from: data)
                return decodedResponse
            } catch {
                throw APIError.invalidData
            }
        }
        throw APIError.invalidURL
    }
    
}
