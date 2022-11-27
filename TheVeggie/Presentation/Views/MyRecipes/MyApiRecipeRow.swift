//
//  Project: TheVeggie
//  MyRecipeRow.swift
//
//
//  Created by Jessica Ernst on 06.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct MyApiRecipeRow: View {
    
    let entity: RecipeEntity
    let vm = MyRecipeViewModel()
    
    var body: some View {
        HStack {
            RectangleImage(image: Image(uiImage: vm.getImageFromData(recipe: entity)))
                .frame(width: 175, height: 160)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(entity.title!)
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .frame(height: 160)
                    .lineLimit(5)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            if entity.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            
            Spacer()
        }
        .background(Color.primary.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

