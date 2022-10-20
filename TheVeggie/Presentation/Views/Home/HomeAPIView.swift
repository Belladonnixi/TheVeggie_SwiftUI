//
//  Project: TheVeggie
//  HomeAPIView.swift
//
//
//  Created by Jessica Ernst on 18.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct HomeAPIView: View {
    
    @State var searchQuery = ""
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                HStack {
                    HomeApiRecipeCard()
                        .padding(8)
                    HomeApiRecipeCard()
                        .padding(8)
                }
                
                HStack {
                    HomeApiRecipeCard()
                        .padding(8)
                    HomeApiRecipeCard()
                        .padding(8)
                }
                
                HStack {
                    HomeApiRecipeCard()
                        .padding(8)
                    HomeApiRecipeCard()
                        .padding(8)
                }
                
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("The Veggie")
        }
        .searchable(text: $searchQuery)
    }
}

struct HomeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAPIView()
    }
}
