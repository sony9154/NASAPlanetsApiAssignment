//
//  ViewModel.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import Foundation
import Combine
import UIKit

class ViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    var cancellables = Set<AnyCancellable>()
    
    func fetchPlanets() {
        Task {
            do {
//                let planets = try await ApiManager.shared.fetchPlanets()
                let planets = try await ApiManager.shared.fetchPlantsFromLocal()
                self.planets = planets
            } catch {
                print("Error fetching planets: \(error)")
            }
        }
    }
}
