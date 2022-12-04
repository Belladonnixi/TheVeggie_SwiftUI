//
//  Project: TheVeggie
//  RecipeLoadingViewModel.swift
//
//
//  Created by Jessica Ernst on 29.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import Combine

class RecipeLoadingViewModel: ObservableObject {
    
    enum State {
        case loading
        case loaded([Recipe])
        case empty(String)
        case error(String)
    }
    
    private var recipes: [Recipe] = []
    
    @Published var state: State = .loading
    private var cancellables = Set<AnyCancellable>()
    
    func load(refresh: Bool) {
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
                    self.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] (returnedValues) in
                if returnedValues.hits.isEmpty {
                    self?.state = .empty("No Recipes found....")
                } else {

                    if refresh {
                        self!.recipes = []
                    }

                    for hit in returnedValues.hits {
                        self!.recipes.append(hit.recipe)
                    }
                    self?.state = .loaded(self!.recipes)
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
