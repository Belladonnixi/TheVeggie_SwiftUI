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

struct AddRecipeView: View {
    
    // ImagePicker
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State var pickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var showSheet = false
    
    // Recipe
    @State var title: String = ""
    @State var category: String = ""
    @State var instruction: String = ""
    @State var source: String = ""
    @State var sourceUrl: String = ""
    @State var totalTime: String = ""
    
    //Ingredients
    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    @State private var newIngredientMeasure = ""
    
    // webview
    @State private var showWebView = false
    @State private var showToggle = false
    
    // WebView
    @StateObject var vm = ApiWebViewViewModel()
    
    @StateObject var addVm = AddRecipeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
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
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Category") {
                    TextField("Category", text: $category, prompt: Text("Category..."))
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Total Time") {
                    TextField("Total Time", text: $totalTime, prompt: Text("Total Time..."))
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Ingredients") {
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
                        
                        addVm.addIngredient(ingredientValues: values)
                        
                        
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
                    
                    List {
                        ForEach(addVm.ingredients) { ingredient in
                            Text(ingredient.text!)
                        }
                        .onDelete(perform: addVm.deleteItems)
                    }
                  
                    
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Preparation...") {
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
                        TextField("Recipe Source", text: $source, prompt: Text("Recipe Source..."))
                        TextField("Recipe Source URL", text: $sourceUrl, prompt: Text("Recipe Source URL..."))
                        if !sourceUrl.isEmpty {
                            Toggle("Show Original Recipe Instructions", isOn: $showWebView)
                        }
                        
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
                
                Button(action: {
                    let value = RecipeValues(
                        title: title,
                        category: category,
                        image: selectedImage ?? UIImage(systemName: "photo.artframe"),
                        imageUrl: "",
                        instruction: instruction,
                        source: source,
                        sourceUrl: sourceUrl,
                        totalTime: Int64(totalTime) ?? 0
                    )
                    addVm.addRecipe(recipeValues: value)
                    
                    newIngredientName = ""
                    newIngredientMeasure = ""
                    newIngredientQuantity = ""
                    selectedImage = nil
                    addVm.ingredients = []
                    
                    title = ""
                    category = ""
                    instruction = ""
                    source = ""
                    sourceUrl = ""
                    totalTime = ""
                }, label: {
                    HStack {
                        Spacer()
                        Label("Save to my recipes", systemImage: "square.and.arrow.down")
                        Spacer()
                    }
                        
                })
                .padding(8)
                .foregroundColor(Color.white)
                .listRowBackground(CustomColor.forestGreen)
                
                
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
        AddRecipeView()
    }
}
