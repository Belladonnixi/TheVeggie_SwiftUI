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
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(vm.recipes) { recipe in
                    NavigationLink {
                        // TODO: - going to MyRecipesDetails 
                    } label: {
                        MyRecipeRow(entity: recipe)
                    }
                    
                }
                .onDelete(perform: vm.deleteItems)
                .listRowBackground(Color.primary.opacity(0.2))
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("My Recipes")
            .scrollContentBackground(.hidden)
            .background(backgroundGradient)
            .toolbar {
                Button("Favorites") {
                    print("Favorite Button Tapped")
                }
            }
        }
    }
}

struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}
