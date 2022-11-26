//
//  Project: TheVeggie
//  MyRecipesView.swift
//
//
//  Created by Jessica Ernst on 04.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct MyRecipesView: View {
    
    @State private var addViewShown = false
    @StateObject var vm = MyRecipeViewModel()
    @State private var showFavoritesOnly = false
    
    var filteredRecipes: [RecipeEntity] {
        vm.recipes.filter { recipe in
            (!showFavoritesOnly || recipe.isFavorite)
        }
    }
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(filteredRecipes) { recipe in
                    NavigationLink {
                        MyRecipeDetailView(recipeId: recipe.objectID, recipe: recipe)
                    } label: {
                        MyRecipeRow(entity: recipe)
                    }
                    
                }
                .onDelete(perform: vm.deleteRecipes)
                .listRowBackground(Color.primary.opacity(0.2))
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("My Recipes")
            .toolbar {
                Toggle("Favorites only", isOn: $showFavoritesOnly)
            }
            .scrollContentBackground(.hidden)
            .background(backgroundGradient)
            .onAppear {
                vm.getRecipes()
            }
        }
    }
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}
