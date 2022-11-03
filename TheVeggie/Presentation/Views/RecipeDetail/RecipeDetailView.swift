//
//  Project: TheVeggie
//  RecipeDetailView.swift
//
//
//  Created by Jessica Ernst on 02.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct RecipeDetailView: View {
    
    var recipe: Recipe
    
    var body: some View {
        
        Form {
            Section {
                VStack {
                    DownloadingImageView(url: recipe.image, key: "\(recipe.label)")
                        .frame(width: 325, height: 300)
                    .aspectRatio(contentMode: .fit)
                    
                    Text("Test recipe title title title title title title title title title title title title title title title ")
                        .font(.title)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                Text("test")
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("meal preparation") {
                Text("test")
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Original Recipe Source") {
                RecipeWebView()
                    .frame(width:325,height: 600)
            }
            .listRowBackground(Color.primary.opacity(0.2))
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Recipe Details")

    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(recipe: Recipe(uri: "uri here", label: "some dish", image: "https://via.placeholder.com/600/92c952", source: "String", url: "url here", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}
