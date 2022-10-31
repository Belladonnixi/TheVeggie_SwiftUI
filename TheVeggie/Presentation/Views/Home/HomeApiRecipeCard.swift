//
//  Project: TheVeggie
//  HomeApiItem.swift
//
//
//  Created by Jessica Ernst on 18.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct HomeApiRecipeCard: View {
    
    let model: Recipe
        
    var body: some View {
        VStack {
            DownloadingImageView(url: model.image, key: "\(model.label)")
                .frame(width: 160, height: 160)
                .aspectRatio(contentMode: .fit)
            
            Text(model.label)
        }
    }
}

struct HomeApiItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeApiRecipeCard(model: Recipe(uri: "uri here", label: "some dish", image: "some photo", source: "some source", url: "url here", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}
