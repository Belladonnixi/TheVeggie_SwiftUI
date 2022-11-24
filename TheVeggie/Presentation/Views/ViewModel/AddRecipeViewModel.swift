//
//  Project: TheVeggie
//  AddRecipeViewModel.swift
//
//
//  Created by Jessica Ernst on 18.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import SwiftUI


class AddRecipeViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    
    @Published var ingredients = [IngredientEntity]()
    
    func addRecipe(recipeValues: RecipeValues) {
        let newRecipe = RecipeEntity(context: manager.context)
        newRecipe.title = recipeValues.title
        newRecipe.category = recipeValues.category
        newRecipe.imageUrl = recipeValues.imageUrl
        newRecipe.source = recipeValues.source
        newRecipe.sourceUrl = recipeValues.sourceUrl
        newRecipe.instruction = recipeValues.instruction
        newRecipe.isFavorite = recipeValues.isFavorite
        newRecipe.ingredients = NSSet(array: ingredients)
        newRecipe.totalTime = recipeValues.totalTime
        
        if let image = recipeValues.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            newRecipe.image = imageData
        }
        
       save()
    }
    
    func addIngredient(ingredientValues: IngredientValues) {
        let newIngredient = IngredientEntity(context: manager.context)
        newIngredient.name = ingredientValues.name
        newIngredient.quantity = ingredientValues.quantity
        newIngredient.measure = ingredientValues.measure
        newIngredient.text = ingredientValues.text
        newIngredient.weight = ingredientValues.weight
        
        ingredients.append(newIngredient)
    }
    
    func save() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(manager.context.delete)
            ingredients.remove(atOffsets: offsets)
        }
    }
}
