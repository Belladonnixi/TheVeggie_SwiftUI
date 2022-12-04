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
    
    // ImagePicker editMode
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var recipeVm = MyRecipeViewModel()
    
    // WebView
    @StateObject var vm = ApiWebViewViewModel()
    
    // favorite recipe
    var recipeIndex: Int {
        recipeVm.recipes.firstIndex(where: { $0.title == recipe.title})!
    }
    
    var body: some View {
        
        Form {
            Section {
                VStack {
                    if recipeVm.isInEditMode {
                        HStack {
                            RectangleImage(image: recipeVm.selectedImage == nil ? Image(systemName: "photo.artframe") : Image(uiImage: self.recipeVm.selectedImage!))
                                .frame(width: 250, height: 225)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(CustomColor.lightGray)
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
                            
                            Button {
                                withAnimation {
                                    recipeVm.pickerPresented = true
                                }
                            } label: {
                                Image(systemName: "camera.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(CustomColor.forestGreen)
                            }
                            .padding(8)
                            .onTapGesture {
                                recipeVm.showSheet = true
                            }
                            .sheet(isPresented: $recipeVm.showSheet) {
                                ImagePicker(selectedImage: $recipeVm.selectedImage)
                            }
                        }
                        TextField("Recipe title", text: $recipeVm.title, prompt: Text("Recipe Title..."))
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
                    } else {
                        RectangleImage(image: recipeVm.selectedImage == nil ? Image(systemName: "photo.artframe") : Image(uiImage: self.recipeVm.selectedImage!))
                            .frame(width: 325, height: 300)
                            .aspectRatio(contentMode: .fit)
                        
                        HStack {
                            Text(recipeVm.title)
                                .font(.title)
                            FavoriteButton(isSet: $recipeVm.recipes[recipeIndex].isFavorite)
                        }
                    }
                }
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Category") {
                TextField("Category", text: $recipeVm.category, prompt: Text("Category..."))
                    .disabled(!recipeVm.isInEditMode)
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Total Time in minutes") {
                TextField("Total Time", text: $recipeVm.totalTime, prompt: Text("Total Time..."))
                    .keyboardType(.numberPad)
                    .disabled(!recipeVm.isInEditMode)
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Ingredients") {
                if recipeVm.isInEditMode {
                    TextField("Ingredient", text: $recipeVm.newIngredientName, prompt: Text("Ingredient..."))
                    HStack {
                        TextField("Quantity", text: $recipeVm.newIngredientQuantity, prompt: Text("Quantity..."))
                        TextField("Unit", text: $recipeVm.newIngredientMeasure, prompt: Text("Unit..."))
                    }
                    Button {
                        
                        recipeVm.addIngredient()
                        
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Ingredient", systemImage: "plus")
                            Spacer()
                        }
                    }
                    .foregroundColor(recipeVm.newIngredientName.isEmpty ? Color.gray : Color.white)
                    .padding(8)
                    .background(recipeVm.newIngredientName.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 5)
                    .disabled(recipeVm.newIngredientName.isEmpty)
                    
                }
                
                List {
                    ForEach(recipeVm.ingredients) { ingredient in
                        Text(ingredient.text!)
                    }
                    .onDelete(perform: recipeVm.deleteItems)
                    .deleteDisabled(!recipeVm.isInEditMode)
                }
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Preparation") {
                List {
                    ZStack(alignment:. topLeading) {
                        TextEditor(text: $recipeVm.instruction)
                            .background(Color("textBackground"))
                            .cornerRadius(10.0)
                            .frame(height: 150.0)
                            .disabled(!recipeVm.isInEditMode)
                    }
                    .padding(.bottom)
                }
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            Section("Recipe Source") {
                VStack {
                    TextField("Recipe Source", text: $recipeVm.source, prompt: Text("Recipe Source..."))
                        .disabled(!recipeVm.isInEditMode)
                    TextField("Recipe Source URL", text: $recipeVm.sourceUrl, prompt: Text("Recipe Source URL..."))
                        .disabled(!recipeVm.isInEditMode)
                    if !recipeVm.sourceUrl.isEmpty {
                        Toggle("Show Original Recipe Instructions", isOn: $recipeVm.showWebView)
                    }
                    
                }
            }
            .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            
            if recipeVm.showWebView {
                
                Section("Original Recipe Source") {
                    RecipeWebView(webView: vm.webView)
                        .onAppear {
                            vm.loadUrl(urlString: recipeVm.sourceUrl)
                        }
                        .frame(width:325,height: 600)
                }
                .listRowBackground(recipeVm.isInEditMode ? CustomColor.forestGreen.opacity(0.2) : Color.primary.opacity(0.2))
            }
        }
        .scrollContentBackground(.hidden)
        .background(backgroundGradient)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("Recipe Details")
        .toolbar {
            
            Button(recipeVm.isInEditMode ? "Cancel" : "Edit") {
                recipeVm.editCancelButtonPressed(recipeId: recipeId!)
            }
            
            if recipeVm.isInEditMode {
                
                Button("Save") {
                
                    recipeVm.updateRecipe(recipeId: recipeId!)
                    
                    recipeVm.isInEditMode.toggle()
                    
                }
                
                Button {
                    recipeVm.deleteRecipe(at: recipeIndex, in: recipeVm.recipes)
                    dismiss()
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            recipeVm.initialSetUpMyRecipeDetail(recipeId: recipeId)
        }
    }
}
