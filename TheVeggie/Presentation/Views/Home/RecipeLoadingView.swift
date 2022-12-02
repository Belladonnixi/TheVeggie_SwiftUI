//
//  Project: TheVeggie
//  RecipeLoadingView.swift
//
//
//  Created by Jessica Ernst on 02.12.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct RecipeLoadingView: View {
    
    @StateObject var vm = RecipeLoadingViewModel()
    
    var body: some View {
        ZStack {
            backgroundGradient.edgesIgnoringSafeArea([.all])
            
            switch vm.state {
            case .loaded(let recipes):
                HomeAPIView(recipes: recipes)
                    .refreshable {
                        vm.load()
                    }
            case .empty(let message):
                MessageView(message: message)
                    .refreshable {
                        vm.load()
                    }
            case .error(let message):
                MessageView(message: message)
                    .refreshable {
                        vm.load()
                    }
            case .loading:
                ProgressView()
                    .onAppear {
                        vm.load()
                    }
            }
                
        }
    }
}

struct RecipeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeLoadingView()
    }
}
