//
//  Project: TheVeggie
//  ContentView.swift
//
//
//  Created by Jessica Ernst on 04.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .apiRecipes
    
    enum Tab {
        case apiRecipes
        case myRecipes
        case addRecipe
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomeAPIView()
                .tabItem {
                    Label("New Recipes", systemImage: "star")
                }
                .tag(Tab.apiRecipes)
            
            MyRecipesView()
                .tabItem {
                    Label("My Recipes", systemImage: "book")
                }
                .tag(Tab.myRecipes)
            
            AddRecipe()
                .tabItem {
                    Label("Add Recipe", systemImage: "plus.app.fill")
                }
                .tag(Tab.addRecipe)
        }
        .accentColor(CustomColor.forestGreen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
