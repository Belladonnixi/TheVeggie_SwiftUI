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
    @State private var isOwnRecipe = false
    
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
            ScrollView(.vertical, showsIndicators: false, content:  {
                VStack(spacing: 16) {
                    ForEach(filteredRecipes) { recipe in
                        NavigationLink {
                            MyRecipeDetailView(recipeId: recipe.objectID, recipe: recipe)
                        } label: {
                            if recipe.isOwnRecipe {
                                MyOwnRecipeRow(entity: recipe)
                            } else {
                                MyApiRecipeRow(entity: recipe)
                            }
                        }
                    }
                    .onDelete(perform: vm.deleteRecipes)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .shadow(radius: 7)
                }
            })
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
