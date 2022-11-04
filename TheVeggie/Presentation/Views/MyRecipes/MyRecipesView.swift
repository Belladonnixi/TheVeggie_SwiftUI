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
    
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
//                ForEach(vm.dataArray, id: \.label) { model in
//                    NavigationLink {
//                        RecipeDetailView(recipe: model)
//                    } label: {
//                        HomeApiRecipeRow(recipe: model)
//                    }
//                }
//                .listRowBackground(Color.primary.opacity(0.2))
                
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("My Recipes")
            .scrollContentBackground(.hidden)
            .background(backgroundGradient)
        }
    }
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}
