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
    
    
    let backgroundGradient = LinearGradient(
        colors: [Color.green.opacity(0.4), Color.yellow.opacity(0.4), Color.orange.opacity(0.4)],
        startPoint: .topLeading, endPoint: .bottomTrailing)
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(vm.dataArray, id: \.label) { model in
                     HomeApiRecipeRow(model: model)
                }
                .listRowBackground(backgroundGradient)
                
                Button("load more", action: vm.dataService.downloadData)
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
