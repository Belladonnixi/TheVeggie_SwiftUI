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
    
    @Published var recipes: [Recipe] = []
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        fetch()
    }
    
    func fetch() {
        guard let url = URL(string: "https://api.edamam.com/api/recipes/v2?type=public&beta=true&q=vegetarian&app_id=\(EdamamApi.appId)&app_key=\(EdamamApi.appKey)&random=true") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: ApiRecipes.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data. \(error)")
                }
            } receiveValue: { [weak self] (returnedValues) in
                for hit in returnedValues.hits {
                    var array = [Recipe]()
                    array.append(hit.recipe)
                    self?.recipes = array
                }
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
