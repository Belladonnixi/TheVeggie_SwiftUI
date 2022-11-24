//
//  Project: TheVeggie
//  MyRecipeDetailView.swift
//
//
//  Created by Jessica Ernst on 16.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI
import CoreData

struct MyRecipeDetailView: View {
    
    var recipeId: NSManagedObjectID?
    
    @StateObject var recipeVm = MyRecipeViewModel()
    
    // Recipe
    @State var title: String = ""
    @State var category: String = ""
    @State var instruction: String = ""
    @State var source: String = ""
    @State var sourceUrl: String = ""
    @State var totalTime: String = ""
    @State private var image = UIImage()
    
    //Ingredients
    @State private var ingredients = [IngredientEntity]()
    
    // webview
    @State private var showWebView = false
    @State private var showToggle = false
    
    // WebView
    @StateObject var vm = ApiWebViewViewModel()
    
    @StateObject var addVm = AddRecipeViewModel()
    
    var body: some View {
        
        Form {
            Section {
                VStack {
                    RectangleImage(image: Image(uiImage: self.image))
                        .frame(width: 325, height: 300)
                        .aspectRatio(contentMode: .fit)
                    
                    Text(title)
                        .font(.title)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Category") {
                Text(category.isEmpty ? "-" : category)
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Total Time") {
                Text(totalTime)
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                ForEach(ingredients) { ingredient in
                    Text(ingredient.text!)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("preparation") {
                VStack(alignment: .leading) {
                    Text("Meal preparation instructions only at source website")
                    
                    if !sourceUrl.isEmpty {
                        Toggle("Show Original Recipe Instructions", isOn: $showWebView)
                    }
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            if showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: sourceUrl)
                        }
                        .frame(width:325,height: 600)
                }
                .listRowBackground(Color.primary.opacity(0.2))
            }
            
            
            
            
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Recipe Details")
        .onAppear {
            guard
                let objectId = recipeId,
                let recipe = recipeVm.fetchRecipe(for: objectId)
            else {
                return
            }
            
            title = recipe.title ?? ""
            category = recipe.category ?? ""
            instruction = recipe.instruction ?? ""
            source = recipe.source ?? ""
            sourceUrl = recipe.sourceUrl ?? ""
            totalTime = "\(recipe.totalTime) min"
            image = recipeVm.getImageFromData(recipe: recipe)
            ingredients = recipe.ingredients?.allObjects as! [IngredientEntity]
        }
        
    }
}

struct MyRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipeDetailView()
    }
}
