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
    @StateObject var vm = HomeApiViewmodel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(vm.dataArray, id: \.label) { model in
                     HomeApiRecipeRow(recipe: model)
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Button("load more", action: vm.dataService.downloadData)
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("The Veggie")
            .scrollContentBackground(.hidden)
            .background(backgroundGradient)
        }
        .searchable(text: $searchQuery)
    }
}

struct HomeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAPIView()
    }
}
