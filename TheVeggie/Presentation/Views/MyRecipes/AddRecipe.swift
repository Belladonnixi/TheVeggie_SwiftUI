//
//  Project: TheVeggie
//  AddRecipe.swift
//
//
//  Created by Jessica Ernst on 04.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct AddRecipe: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                }
                .listRowBackground(Color.primary.opacity(0.2))
            }
            .scrollContentBackground(.hidden)
            .background(backgroundGradient)
            .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Add Recipe")
        }
        
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe()
    }
}
