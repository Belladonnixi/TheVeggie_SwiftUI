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

struct MyRecipeRow: View {
    
    let entity: RecipeEntity
    let vm = MyRecipeViewModel()
    
    var body: some View {
        HStack {
            RectangleImage(image: Image(uiImage: vm.getImageFromData(recipe: entity)))
                .frame(width: 160, height: 160)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading) {
                Text(entity.title!)
                    .font(.headline)
                    .frame(height: 160)
                    .lineLimit(5)
                    .scaledToFit()
                    .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 0.0))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
//            if entity.isFavorite {
//                Image(systemName: "star.fill")
//                    .foregroundColor(.yellow)
//            }
        }
    }
}

//struct MyRecipeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MyRecipeRow(entity: R)
//    }
//}
