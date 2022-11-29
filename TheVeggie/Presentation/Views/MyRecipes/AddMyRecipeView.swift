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

struct AddMyRecipeView: View {
    
    // ImagePicker
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    
    // WebView
    @StateObject var vm = ApiWebViewViewModel()
    
    @StateObject var addVm = MyRecipeViewModel()
    
    // saved Alert
    @State private var presentAlert = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        
                        RectangleImage(image: addVm.selectedImage == nil ? Image(systemName: "photo.artframe") : Image(uiImage: self.addVm.selectedImage!))
                            .frame(width: 250, height: 225)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(CustomColor.lightGray)
                            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 0))
                        
                        Button {
                            withAnimation {
                                addVm.pickerPresented = true
                            }
                        } label: {
                            Image(systemName: "camera.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(CustomColor.forestGreen)
                        }
                        .padding(8)
                        .onTapGesture {
                            addVm.showSheet = true
                        }
                        .sheet(isPresented: $addVm.showSheet) {
                            ImagePicker(selectedImage: $addVm.selectedImage)
                        }
                    }
                    TextField("Recipe title", text: $addVm.title, prompt: Text("Recipe Title..."))
                }
                .listRowBackground(CustomColor.forestGreen.opacity(0.2))
                
                Section("Category") {
                    TextField("Category", text: $addVm.category, prompt: Text("Category..."))
                }
                .listRowBackground(CustomColor.forestGreen.opacity(0.2))
                
                Section("Total Time in minutes") {
                    TextField("Total Time", text: $addVm.totalTime, prompt: Text("Total Time..."))
                }
                .listRowBackground(CustomColor.forestGreen.opacity(0.2))
                
                Section("Ingredients") {
                    TextField("Ingredient", text: $addVm.newIngredientName, prompt: Text("Ingredient..."))
                    HStack {
                        TextField("Quantity", text: $addVm.newIngredientQuantity, prompt: Text("Quantity..."))
                        TextField("Unit", text: $addVm.newIngredientMeasure, prompt: Text("Unit..."))
                    }
                    Button {
                                                
                        addVm.addIngredient()
                        
                    } label: {
                        HStack {
                            Spacer()
                            Label("Add Ingredient", systemImage: "plus")
                            Spacer()
                        }
                    }
                    .foregroundColor(addVm.newIngredientName.isEmpty ? Color.gray : Color.white)
                    .padding(8)
                    .background(addVm.newIngredientName.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 5)
                    .disabled(addVm.newIngredientName.isEmpty)
                    
                    List {
                        ForEach(addVm.ingredients) { ingredient in
                            Text(ingredient.text!)
                        }
                        .onDelete(perform: addVm.deleteItems)
                    }
                }
                .listRowBackground(CustomColor.forestGreen.opacity(0.2))
                
                Section("Preparation...") {
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
                        TextField("Recipe Source", text: $addVm.source, prompt: Text("Recipe Source..."))
                        TextField("Recipe Source URL", text: $addVm.sourceUrl, prompt: Text("Recipe Source URL..."))
                        if !addVm.sourceUrl.isEmpty {
                            Toggle("Show Original Recipe Instructions", isOn: $addVm.showWebView)
                        }
                        
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
            .safeAreaInset(edge: .bottom) {
                Button(action: {
                    
                    addVm.image = addVm.selectedImage ?? UIImage(systemName: "photo.artframe")
                   
                    addVm.addRecipe()
                                       
                    presentAlert = true
                    
                    addVm.selectedImage = nil
                    addVm.ingredients = []
                    addVm.title = ""
                    addVm.category = ""
                    addVm.instruction = ""
                    addVm.source = ""
                    addVm.sourceUrl = ""
                    addVm.totalTime = ""
                    
                }, label: {
                    HStack {
                        Spacer()
                        Label("Save to my recipes", systemImage: "square.and.arrow.down")
                        Spacer()
                    }
                        
                })
                .padding(.vertical)
                .frame(width: 355)
                .alert("Recipe saved", isPresented: $presentAlert, actions: {})
                .foregroundColor(addVm.title.isEmpty ? Color.gray : Color.white)
                .background(addVm.title.isEmpty ? CustomColor.lightGray : CustomColor.forestGreen)
                .disabled(addVm.title.isEmpty)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding( .bottom)
                .shadow(radius: 5)
            }
            .onAppear {
                addVm.ingredients = []
            }
        }
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddMyRecipeView()
    }
}
