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
import SwiftUI

class MyRecipeViewModel: ObservableObject {
    
    let manager = CoreDataManager.instance
    @Published var recipes: [RecipeEntity] = []
    @Published var ingredients: [IngredientEntity] = []
    @Published var isFavorite: Bool? {
        didSet {
            update()
        }
    }
    
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
    
    func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(manager.context.delete)
            recipes.remove(atOffsets: offsets)
        }
        update()
    }
    
    func update() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
        }
    }
    
    func fetchRecipe(for objectId: NSManagedObjectID) ->
    RecipeEntity? {
        guard let recipe = manager.context.object(with: objectId) as? RecipeEntity else {
            return nil
        }
        return recipe
    }
    
    // MARK: - Edit Mode
    func updateRecipe(
        recipeId: NSManagedObjectID,
        with recipeValues: RecipeValues
    ) {
        let recipe: RecipeEntity
        let fetchedRecipe = fetchRecipe(for: recipeId)
        recipe = fetchedRecipe!
        
        recipe.title = recipeValues.title
        recipe.category = recipeValues.category
        recipe.imageUrl = recipeValues.imageUrl
        recipe.source = recipeValues.source
        recipe.sourceUrl = recipeValues.sourceUrl
        recipe.instruction = recipeValues.instruction
        recipe.isFavorite = recipeValues.isFavorite
        recipe.ingredients = NSSet(array: ingredients)
        recipe.totalTime = Int64(recipeValues.totalTime) ?? 0
        
        if let image = recipeValues.image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            recipe.image = imageData
        }
        
        update()
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
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(manager.context.delete)
            ingredients.remove(atOffsets: offsets)
        }
    }
    
}
