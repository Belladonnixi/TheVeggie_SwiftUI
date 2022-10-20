//
//  Project: TheVeggie
//  RecipeModelDataService.swift
//
//
//  Created by Jessica Ernst on 20.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import Combine

class RecipeModelDataService {
    
    static let instance = RecipeModelDataService() // Singleton
    
    @Published var recipes: [RecipeModel] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        downloadData()
    }
    
    func downloadData() {
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&beta=true&q=vegetarian&app_id=\(appId)&app_key=\(appKey)&random=true") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [RecipeModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] (returnedRecipes) in
                self?.recipes = returnedRecipes
            }
            .store(in: &cancellables)
    }
    
    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
