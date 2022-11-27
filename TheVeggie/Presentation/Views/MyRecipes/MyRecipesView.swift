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
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    @State private var addViewShown = false
    @StateObject var vm = MyRecipeViewModel()
    @State private var showFavoritesOnly = false
    @State private var isOwnRecipe = false
    @State var searchText: String = ""
    
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
            ScrollViewReader { proxyReader in
                
                ZStack {
                    backgroundGradient.edgesIgnoringSafeArea([.all])
                    
                    ScrollView(.vertical, showsIndicators: false, content:  {
                        
                        _HSpacer(minWidth: 16)
                        
                        HStack {
                            HStack {
                                HStack {
                                    LazyVStack.init(spacing: 16, content: {
                                        
                                        ForEach(filteredRecipes) { recipe in
                                            let toDeleteIndex = vm.recipes.firstIndex(of: recipe)
                                            NavigationLink {
                                                MyRecipeDetailView(recipeId: recipe.objectID, recipe: recipe)
                                            } label: {
                                                if recipe.isOwnRecipe {
                                                    HStack {
//                                                        Button {
//                                                            vm.deleteRecipe(at: toDeleteIndex!)
//                                                        } label: {
//                                                            Image(systemName: "trash")
//                                                                .font(.system(size: 20, weight: .semibold))
//                                                                .foregroundColor(.white)
//                                                                .padding()
//                                                                .background(.red)
//                                                                .clipShape(Circle())
//                                                                .shadow(radius: 10)
//                                                        }
                                                        
                                                        MyOwnRecipeRow(entity: recipe)
                                                    }
                                                    
                                                } else {
                                                    HStack {
//                                                        Button {
//                                                            vm.deleteRecipe(at: toDeleteIndex!)
//                                                        } label: {
//                                                            Image(systemName: "trash")
//                                                                .font(.system(size: 20, weight: .semibold))
//                                                                .foregroundColor(.white)
//                                                                .padding()
//                                                                .background(.red)
//                                                                .clipShape(Circle())
//                                                                .shadow(radius: 10)
//                                                        }
                                                        
                                                        MyApiRecipeRow(entity: recipe)
                                                    }
                                                }
                                            }
                                            .contextMenu {
                                                Button {
                                                    vm.deleteRecipe(at: toDeleteIndex!)
                                                } label: {
                                                    HStack {
                                                        Text("Delete")
                                                            .foregroundColor(.red)
                                                        Image(systemName: "trash")
                                                    }
                                                }
                                            }
                                        }
//                                        .onDelete(perform: vm.deleteRecipes)
                                    })
                                    .padding()
                                }
                            }
                        .id("TOP")
                        }
                    })
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationTitle("My Recipes")
                    .toolbar {
                        Toggle("Favorites only", isOn: $showFavoritesOnly)
                    }
                    .onAppear {
                        vm.getRecipes()
                    }
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                proxyReader.scrollTo("TOP", anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .background(.orange.opacity(0.7))
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                            .padding(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                            .animation(.easeInOut, value: 1)
                        ,alignment: .bottomTrailing
                    )
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
