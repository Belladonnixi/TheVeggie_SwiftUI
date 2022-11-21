//
//  Project: TheVeggie
//  MyRecipeViewModel.swift
//
//
//  Created by Jessica Ernst on 04.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import CoreData
import UIKit

class MyRecipeViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var recipes: [RecipeEntity] = []
    @Published var ingredients: [IngredientEntity] = []
    
    init() {
        getRecipes()
        getIngredients()
    }
    
    func getRecipes() {
        let request = NSFetchRequest<RecipeEntity>(entityName: "RecipeEntity")
        
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
        do {
            recipes = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func getIngredients() {
        let request = NSFetchRequest<IngredientEntity>(entityName: "IngredientEntity")
        
        do {
            ingredients = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching data. \(error.localizedDescription)")
        }
    }
    
    func getImageFromData(recipe: RecipeEntity) -> UIImage  {
        //this is just a placeholder
        var finalImage = (UIImage(systemName: "photo.artframe"))
        if let data = recipe.image {
            if let image = UIImage(data: data as Data) {
                finalImage = image
            }
        }
        return finalImage!
    }
    
    func deleteRecipes() {
        
    }
}