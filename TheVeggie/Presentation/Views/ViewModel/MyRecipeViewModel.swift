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
    
    // MARK: - Core Data
    let manager = CoreDataManager.instance
    
    @Published var recipes: [RecipeEntity] = []
    @Published var ingredients: [IngredientEntity] = []
    
    // Favorite
    @Published var saveIsFavorite: Bool? {
        didSet {
            update()
        }
    }
    
    // Recipe
    @Published var title: String = ""
    @Published var category: String = ""
    @Published var instruction: String = ""
    @Published var source: String = ""
    @Published var sourceUrl: String = ""
    @Published var totalTime: String = ""
    @Published var imageUrl: String = ""
    @Published var image: UIImage?
    @Published var isOwnRecipe: Bool = false
    @Published var isFavorite: Bool = false
    
    // MARK: - EditMode
    
    // EditMode
    @Published var isInEditMode = false
    
    //Ingredients editMode
    @Published var newIngredientName = ""
    @Published var newIngredientQuantity = ""
    @Published var newIngredientMeasure = ""
    
    // imagePicker
    @Published var pickerPresented = false
    @Published var selectedImage: UIImage?
    @Published var showSheet = false
    
    
    // webview
    @Published var showWebView = false
    @Published var showToggle = false
    
    init() {
        getRecipes()
        getIngredients()
    }
    
    // MARK: - Core Data funcs
    
    // fetch all recipes
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
    
    // fetch ingredients for recipe
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
    
    // fetch recipe with objectId
    func getSpecificRecipe(for objectId: NSManagedObjectID) ->
    RecipeEntity? {
        guard let recipe = manager.context.object(with: objectId) as? RecipeEntity else {
            return nil
        }
        return recipe
    }

    // delete, save, update recipe
    func deleteRecipe(at index: Int) {
        withAnimation {
            let deletedRecipe = recipes[index]
            self.manager.context.delete(deletedRecipe)
        }
        save()
    }
    
    func save() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
            self.getRecipes()
            self.getIngredients()
        }
    }
    
    func update() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.manager.save()
        }
    }
    
    // MARK: - Edit Mode funcs

    func updateRecipe(recipeId: NSManagedObjectID) {
        let recipe: RecipeEntity
        let fetchedRecipe = getSpecificRecipe(for: recipeId)
        recipe = fetchedRecipe!
        
        recipe.title = title
        recipe.category = category
        recipe.imageUrl = imageUrl
        recipe.source = source
        recipe.sourceUrl = sourceUrl
        recipe.instruction = instruction
        recipe.isFavorite = isFavorite
        recipe.ingredients = NSSet(array: ingredients)
        recipe.totalTime = Int64(totalTime) ?? 0
        
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            recipe.image = imageData
        }
        
        update()
    }
    
    func addIngredient() {
        let newIngredient = IngredientEntity(context: manager.context)
        newIngredient.name = newIngredientName
        newIngredient.quantity = Float(newIngredientQuantity) ?? 0
        newIngredient.measure = newIngredientMeasure
        newIngredient.text = "\(newIngredientQuantity) \(newIngredientMeasure) \(newIngredientName)"
        
        ingredients.append(newIngredient)
        
        newIngredientName = ""
        newIngredientMeasure = ""
        newIngredientQuantity = ""
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ingredients[$0] }.forEach(manager.context.delete)
            ingredients.remove(atOffsets: offsets)
        }
    }
    
    func editCancelButtonPressed(recipeId: NSManagedObjectID) {
        
        let recipe: RecipeEntity
        let fetchedRecipe = getSpecificRecipe(for: recipeId)
        recipe = fetchedRecipe!
        
        if isInEditMode {
            
            manager.context.rollback()
            
            self.title = recipe.title ?? ""
            self.category = recipe.category ?? ""
            self.totalTime = recipe.totalTime.description
            self.instruction = recipe.instruction ?? "Instructions"
            self.ingredients = recipe.ingredients?.allObjects as! [IngredientEntity]
            
            self.selectedImage = getImageFromData(recipe: recipe)
            
            self.newIngredientName = ""
            self.newIngredientMeasure = ""
            self.newIngredientQuantity = ""
            
        }
        isInEditMode.toggle()
    }
}
