//
//  Project: TheVeggie
//  HomeAPIViewModel.swift
//
//
//  Created by Jessica Ernst on 21.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import Combine

class HomeApiViewmodel: ObservableObject {
    
    @Published var dataArray: [Recipe] = []
    var cancellables = Set<AnyCancellable>()

    let dataService = RecipeModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$recipes
            .sink { [weak self] (returnedRecipes) in
                self?.dataArray.append(contentsOf: returnedRecipes)
            }
            .store(in: &cancellables)
    }
}
