//
//  Project: TheVeggie
//  FavoriteButton.swift
//
//
//  Created by Jessica Ernst on 07.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    
    @StateObject var isFavorite = MyRecipeViewModel()
    
    var body: some View {
        Button {
            isSet.toggle()
            isFavorite.isFavorite = isSet
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .white)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
