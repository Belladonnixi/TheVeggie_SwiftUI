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

struct ApiRecipeDetailView: View {
    
    var recipe: Recipe
    
    @StateObject var vm = ApiWebViewViewModel()
    
    @State private var showWebView = false
    
    @State private var path = NavigationPath()
    
    
    
    var body: some View {
        
        Form {
            Section {
                VStack {
                    DownloadingImageView(url: recipe.image, key: "\(recipe.label)")
                        .frame(width: 325, height: 300)
                        .aspectRatio(contentMode: .fit)
                    
                    Text(recipe.label)
                        .font(.title)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            
            NavigationLink {
                AddApiRecipeView(recipe: recipe)
            } label: {
                HStack {
                    Spacer()
                    Label("Save to my recipes", systemImage: "heart.fill")
                    Spacer()
                }
            }
            .padding(8)
            .foregroundColor(Color.white)
            .listRowBackground(CustomColor.forestGreen)
            
            Section("Total Time") {
                Text("\(recipe.totalTime) min")
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                ForEach(recipe.ingredients,id: \.foodID ) { ingredient in
                    Text(ingredient.text)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("preparation") {
                VStack(alignment: .leading) {
                    Text("Meal preparation instructions only at source website")
                    
                    Toggle("Show Original Recipe Instructions", isOn: $showWebView)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            if showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: recipe.url)
                        }
                        .frame(width:325,height: 600)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(8)
                }
                .listRowBackground(Color.primary.opacity(0.2))
            }
            
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Recipe Details")
    }
    
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ApiRecipeDetailView(recipe: Recipe(uri: "uri here", label: "some dish", image: "https://via.placeholder.com/600/92c952", source: "String", url: "https://www.taste.com.au/recipes/lentils-crispy-brussel-sprouts-roasted-mushroom/782c78fa-d9b9-4505-b876-e3d6667b8b7e", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}
