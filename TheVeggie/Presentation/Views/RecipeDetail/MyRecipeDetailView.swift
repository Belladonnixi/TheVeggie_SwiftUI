//
//  Project: TheVeggie
//  MyRecipeDetailView.swift
//
//
//  Created by Jessica Ernst on 16.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI
import CoreData

struct MyRecipeDetailView: View {
    
    var recipeId: NSManagedObjectID?
    
    var recipe: RecipeEntity
    
    @StateObject var recipeVm = MyRecipeViewModel()
    
    // Recipe
    @State var title: String = ""
    @State var category: String = ""
    @State var instruction: String = ""
    @State var source: String = ""
    @State var sourceUrl: String = ""
    @State var totalTime: String = ""
    @State private var image = UIImage()
    
    // webview
    @State private var showWebView = false
    @State private var showToggle = false
    
    // WebView
    @StateObject var vm = ApiWebViewViewModel()
    
    // EditMode
    @State private var isInEditMode = false
    
    //Ingredients editMode
    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    @State private var newIngredientMeasure = ""
    
    // ImagePicker editMode
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var pickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var showSheet = false
    
    // favorite
    var recipeIndex: Int {
        recipeVm.recipes.firstIndex(where: { $0.title == recipe.title})!
    }
    
    var body: some View {
        
        Form {
            Section {
                VStack {
                    if isInEditMode {
                        HStack {
                            
                            RectangleImage(image: selectedImage == nil ? Image(systemName: "photo.artframe") : Image(uiImage: self.selectedImage!))
                                .frame(width: 230, height: 200)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(CustomColor.lightGray)
                                .padding(8)
                            
                            Button {
                                withAnimation {
                                    pickerPresented = true
                                }
                            } label: {
                                Image(systemName: "camera.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(CustomColor.forestGreen)
                            }
                            .padding()
                            .onTapGesture {
                                showSheet = true
                            }
                            .sheet(isPresented: $showSheet) {
                                ImagePicker(selectedImage: $selectedImage)
                            }
                        }
                        TextField("Recipe title", text: $title, prompt: Text("Recipe Title..."))
                    } else {
                        RectangleImage(image: selectedImage == nil ? Image(systemName: "photo.artframe") : Image(uiImage: self.selectedImage!))
                            .frame(width: 325, height: 300)
                            .aspectRatio(contentMode: .fit)
                        
                        HStack {
                            Text(title)
                                .font(.title)
                            FavoriteButton(isSet: $recipeVm.recipes[recipeIndex].isFavorite)
                            
                        }
                    }
                }
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Category") {
                TextField("Category", text: $category, prompt: Text("Category..."))
                    .disabled(!isInEditMode)
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Total Time") {
                TextField("Total Time", text: $totalTime, prompt: Text("Total Time..."))
                    .disabled(!isInEditMode)
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                if isInEditMode {
                    TextField("Ingredient", text: $newIngredientName, prompt: Text("Ingredient..."))
                    HStack {
                        TextField("Quantity", text: $newIngredientQuantity, prompt: Text("Quantity..."))
                        TextField("Unit", text: $newIngredientMeasure, prompt: Text("Unit..."))
                    }
                    Button {
                        let values = IngredientValues(
                            name: newIngredientName,
                            text: "\(newIngredientQuantity) \(newIngredientMeasure) \(newIngredientName)",
                            measure: newIngredientMeasure,
                            quantity: Float(newIngredientQuantity) ?? 0,
                            weight: 0.00)
                        
                        recipeVm.addIngredient(ingredientValues: values)
                        
                        newIngredientName = ""
                        newIngredientMeasure = ""
                        newIngredientQuantity = ""
                        
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Ingredient", systemImage: "plus")
                            Spacer()
                        }
                    }
                    .foregroundColor(newIngredientName.isEmpty ? Color.gray : Color.white)
                    .padding(8)
                    .background(newIngredientName.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .disabled(newIngredientName.isEmpty)
                }
                
                List {
                    ForEach(recipeVm.ingredients) { ingredient in
                        Text(ingredient.text!)
                    }
                    .onDelete(perform: recipeVm.deleteItems)
                    .deleteDisabled(!isInEditMode)
                }
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("preparation") {
                List {
                    ZStack(alignment:. topLeading) {
                        TextEditor(text: $instruction)
                            .foregroundColor(Color.black)
                            .background(Color("textBackground"))
                            .cornerRadius(10.0)
                            .frame(height: 150.0)
                            .disabled(!isInEditMode)
                    }
                    .padding(.bottom)
                }
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Recipe Source") {
                VStack {
                    TextField("Recipe Source", text: $source, prompt: Text("Recipe Source..."))
                        .disabled(!isInEditMode)
                    TextField("Recipe Source URL", text: $sourceUrl, prompt: Text("Recipe Source URL..."))
                        .disabled(!isInEditMode)
                    if !sourceUrl.isEmpty {
                        Toggle("Show Original Recipe Instructions", isOn: $showWebView)
                    }
                    
                }
            }
            .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            if showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: sourceUrl)
                        }
                        .frame(width:325,height: 600)
                }
                .listRowBackground(isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            }            
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Recipe Details")
        .toolbar {
            ToolbarItem {
                Button(isInEditMode ? "Cancel" : "Edit") {
                    editCancelButtonPressed()
                }
            }
            if isInEditMode {
                ToolbarItem {
                    Button("Save") {
                        let value = RecipeValues(
                            title: title,
                            category: category,
                            image: selectedImage ?? UIImage(systemName: "photo.artframe"),
                            imageUrl: "",
                            instruction: instruction,
                            source: source,
                            sourceUrl: sourceUrl,
                            totalTime: totalTime
                        )
                        recipeVm.updateRecipe(recipeId: recipeId!, with: value)
                        
                        isInEditMode.toggle()
                    }
                }
            }
        }
        .onAppear {
            guard
                let objectId = recipeId,
                let recipe = recipeVm.fetchRecipe(for: objectId)
            else {
                return
            }
            
            title = recipe.title ?? ""
            category = recipe.category ?? ""
            instruction = recipe.instruction ?? ""
            source = recipe.source ?? ""
            sourceUrl = recipe.sourceUrl ?? ""
            totalTime = recipe.totalTime.description
            selectedImage = recipeVm.getImageFromData(recipe: recipe)
            recipeVm.ingredients = recipe.ingredients?.allObjects as! [IngredientEntity]
        }
    }
    
    private func editCancelButtonPressed() {
        
        if isInEditMode {
            
            viewContext.rollback()
            
            self.title = recipe.title ?? ""
            self.category = recipe.category ?? ""
            self.totalTime = recipe.totalTime.description
            self.instruction = recipe.instruction ?? "Instructions"
            self.recipeVm.ingredients = recipe.ingredients?.allObjects as! [IngredientEntity]
            print(recipeVm.ingredients)
            self.selectedImage = recipeVm.getImageFromData(recipe: recipe)
            
            self.newIngredientName = ""
            self.newIngredientMeasure = ""
            self.newIngredientQuantity = ""
            
        }
        isInEditMode.toggle()
    }
}
