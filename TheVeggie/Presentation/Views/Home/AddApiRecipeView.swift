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
    
    // Recipe
    @State var title: String = ""
    @State var category: String = ""
    @State var instruction: String = "Meal preparation instructions only at source website"
    @State var source: String = ""
    @State var sourceUrl: String = ""
    @State var imageUrl: String = ""
    @State var imageKey: String = ""
    @State var totalTime: String = ""
    @State var image: UIImage?
    
    // webview
    @State private var showWebView = false
    @State private var showToggle = false
    
    @StateObject var vm = ApiWebViewViewModel()
    
    @StateObject var addVm = AddRecipeViewModel()
    
    var body: some View {
        Form {
            Section {
                
                DownloadingImageView(url: imageUrl  , key: imageKey)
                    .frame(width: 300, height: 250)
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                
                
                TextField("Recipe title", text: $title, prompt: Text("Recipe Title"))
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Category") {
                TextField("Category", text: $category, prompt: Text("Category"))
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Total Time") {
                TextField("Total Time", text: $totalTime, prompt: Text("Total Time..."))
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                ForEach(recipe.ingredients,id: \.foodID ) { ingredient in
                    HStack {
                        Text(ingredient.text)
                    }
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Preparation") {
                List {
                    ZStack(alignment:. topLeading) {
                        TextEditor(text: $instruction)
                            .foregroundColor(Color.black)
                            .background(Color("textBackground"))
                            .cornerRadius(10.0)
                            .frame(height: 150.0)
                    }
                    .padding(.bottom)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            Section("Recipe Source") {
                VStack {
                    TextField("Recipe Source", text: $source, prompt: Text("Recipe Source"))
                    TextField("Recipe Source URL", text: $sourceUrl, prompt: Text("Recipe Source URL"))
                    Toggle("Show Original Recipe Instructions", isOn: $showWebView)
                }
            }
            .listRowBackground(Color.primary.opacity(0.2))
            
            if showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: sourceUrl)
                        }
                        .frame(width:325,height: 600)
                }
                .listRowBackground(Color.primary.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
            }
            
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Add Recipe")
        .onAppear {
            title = recipe.label
            source = recipe.source
            sourceUrl = recipe.url
            imageKey = "\(recipe.label)"
            imageUrl = recipe.image
            totalTime = "\(recipe.totalTime) min"
        }
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                
                for ingredient in recipe.ingredients {
                    let value = IngredientValues(
                        name: ingredient.food,
                        text: ingredient.text,
                        measure: ingredient.measure ?? "",
                        quantity: Float(ingredient.quantity),
                        weight: Float(ingredient.weight )
                    )
                    addVm.addIngredient(ingredientValues: value)
                }
            
                let value = RecipeValues(
                    title: title,
                    category: category,
                    image: ImageLoadingViewModel(url: imageUrl  , key: imageKey).image ?? UIImage(systemName: "photo.artframe"),
                    imageUrl: "",
                    instruction: instruction,
                    source: source,
                    sourceUrl: sourceUrl,
                    totalTime: String(recipe.totalTime)
                )
                addVm.addRecipe(recipeValues: value)
                
                addVm.ingredients = []
                
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
            .foregroundColor(title.isEmpty ? Color.gray : Color.white)
            .background(title.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
            .disabled(title.isEmpty)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding( .bottom)
            
        }
    }
}


struct AddApiRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddApiRecipeView(recipe: Recipe(uri: "uri here", label: "some dish", image: "https://via.placeholder.com/600/92c952", source: "String", url: "https://www.taste.com.au/recipes/lentils-crispy-brussel-sprouts-roasted-mushroom/782c78fa-d9b9-4505-b876-e3d6667b8b7e", shareAs: "redipe", yield: 4, ingredients: [Ingredient(text: "some", quantity: 2.00, measure: "spoon", food: "some food", weight: 32.00, foodCategory: "something", foodID: "some id", image: "some image")], calories: 35.00, totalWeight: 4878.00, totalTime: 85, cuisineType: ["american"], mealType: [MealType.lunchDinner], dishType: ["some"]))
    }
}
