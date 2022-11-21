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

struct AddRecipe: View {
    
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
    
    //Ingredients
    
    // webview
    @State private var showWebView = false
    @State private var showToggle = false
    
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
                    TextField("Recipe title", text: $title, prompt: Text("Recipe Title"))
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Category") {
                    TextField("Category", text: $category, prompt: Text("Category"))
                }
                .listRowBackground(Color.primary.opacity(0.2))
                
                Section("Ingredients") {
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
                
                Button(action: {
                    print("Save to my recipes")
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
        AddRecipe()
    }
}
