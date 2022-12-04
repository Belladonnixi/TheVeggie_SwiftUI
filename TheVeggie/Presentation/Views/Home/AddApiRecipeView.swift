//
//  Project: TheVeggie
//  AddApiRecipe.swift
//
//
//  Created by Jessica Ernst on 21.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct AddApiRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var recipe: Recipe
    
    @StateObject var vm = ApiWebViewViewModel()
    
    @StateObject var addVm = MyRecipeViewModel()
    
    var body: some View {
        Form {
            Section {
                
                DownloadingImageView(url: addVm.imageUrl  , key: addVm.imageKey)
                    .frame(width: 325, height: 300)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                
                
                TextField("Recipe title", text: $addVm.title, prompt: Text("Recipe Title"))
            }
            .listRowBackground(CustomColor.forestGreen.opacity(0.2))
            
            Section("Total Time in minutes") {
                TextField("Total Time", text: $addVm.totalTime, prompt: Text("Total Time..."))
                    .keyboardType(.numberPad)
            }
            .listRowBackground(CustomColor.forestGreen.opacity(0.2))
            
            Section("Ingredients") {
                ForEach(recipe.ingredients,id: \.foodID ) { ingredient in
                    HStack {
                        Text(ingredient.text)
                    }
                }
            }
            .listRowBackground(CustomColor.forestGreen.opacity(0.2))
            
            Section("Preparation") {
                List {
                    ZStack(alignment:. topLeading) {
                        TextEditor(text: $addVm.instruction)
                            .background(Color("textBackground"))
                            .cornerRadius(10.0)
                            .frame(height: 150.0)
                    }
                    .padding(.bottom)
                }
            }
            .listRowBackground(CustomColor.forestGreen.opacity(0.2))
            
            Section("Recipe Source") {
                VStack {
                    TextField("Recipe Source", text: $addVm.source, prompt: Text("Recipe Source"))
                    TextField("Recipe Source URL", text: $addVm.sourceUrl, prompt: Text("Recipe Source URL"))
                    Toggle("Show Original Recipe Instructions", isOn: $addVm.showWebView)
                }
            }
            .listRowBackground(CustomColor.forestGreen.opacity(0.2))
            
            if addVm.showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: addVm.sourceUrl)
                        }
                        .frame(width:325,height: 600)
                }
                .listRowBackground(CustomColor.forestGreen.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
            }
            
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Add Recipe")
        .onAppear {
            addVm.initialSetUpAddApiRecipeView(recipe: recipe)
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                addVm.addApiIngredients(recipe: recipe)
                addVm.addApiRecipe()
                addVm.clearIngredients()
                
                dismiss()
                
            }, label: {
                HStack {
                    Spacer()
                    Label("Save to my recipes", systemImage: "square.and.arrow.down")
                    Spacer()
                }
                
            })
            .padding(.vertical)
            .frame(width: 355)
            .foregroundColor(addVm.title.isEmpty ? Color.gray : Color.white)
            .background(addVm.title.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
            .disabled(addVm.title.isEmpty)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .padding( .bottom)
        }
    }
}


struct AddApiRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddApiRecipeView(recipe: Recipe(uri: "uri here", label: "some dish", image: "https://via.placeholder.com/600/92c952", source: "String", url: "https://www.taste.com.au/recipes/lentils-crispy-brussel-sprouts-roasted-mushroom/782c78fa-d9b9-4505-b876-e3d6667b8b7e", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}
