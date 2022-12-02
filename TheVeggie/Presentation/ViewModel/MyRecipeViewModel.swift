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
            save()
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
    @Published var imageKey: String = ""
    
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
    
    // adding recipe
    func addMyRecipe() {
        let newRecipe = RecipeEntity(context: manager.context)
        newRecipe.title = title
        newRecipe.category = category
        newRecipe.imageUrl = ""
        newRecipe.source = source
        newRecipe.sourceUrl = sourceUrl
        newRecipe.instruction = instruction
        newRecipe.isFavorite = false
        newRecipe.ingredients = NSSet(array: ingredients)
        newRecipe.totalTime = Int64(totalTime) ?? 0
        newRecipe.isOwnRecipe = true
        
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            newRecipe.image = imageData
        }
        
        save()
        
        selectedImage = nil
        ingredients = []
        title = ""
        category = ""
        instruction = ""
        source = ""
        sourceUrl = ""
        totalTime = ""
        
    }
    
    func clearIngredients() {
        ingredients = []
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
        getRecipes()
    }
    
    func save() {
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
        
        save()
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
    
    func addApiIngredients(recipe: Recipe) {
        
        for ingredient in recipe.ingredients {
            let newIngredient = IngredientEntity(context: manager.context)
            newIngredient.name = ingredient.food
            newIngredient.text = ingredient.text
            newIngredient.measure = ingredient.measure ?? ""
            newIngredient.quantity = Float(ingredient.quantity)
            newIngredient.weight = Float(ingredient.weight )
            
            ingredients.append(newIngredient)
        }
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
    
    // MARK: - API
    // adding recipe from api
    func addApiRecipe() {
        let newRecipe = RecipeEntity(context: manager.context)
        newRecipe.title = title
        newRecipe.category = category
        newRecipe.imageUrl = ""
        newRecipe.source = source
        newRecipe.sourceUrl = sourceUrl
        newRecipe.instruction = instruction
        newRecipe.isFavorite = false
        newRecipe.ingredients = NSSet(array: ingredients)
        newRecipe.totalTime = Int64(totalTime) ?? 0
        newRecipe.isOwnRecipe = false
        
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 1.0)
            newRecipe.image = imageData
        }
        
        save()
    }
    
    // initilizing AddApiRecipeView
    func initialSetUpAddApiRecipeView(recipe: Recipe) {
        title = recipe.label
        source = recipe.source
        sourceUrl = recipe.url
        imageKey = "\(recipe.label)"
        imageUrl = recipe.image
        totalTime = recipe.totalTime.description
        instruction = "Meal preparation instructions only at source website"
        image = ImageLoadingViewModel(url: imageUrl  , key: imageKey).image ?? UIImage(systemName: "photo.artframe")
    }
}
