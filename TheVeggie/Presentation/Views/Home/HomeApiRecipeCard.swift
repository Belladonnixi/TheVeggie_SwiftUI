//
//  Project: TheVeggie
//  HomeApiItem.swift
//
//
//  Created by Jessica Ernst on 18.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct HomeApiRecipeCard: View {
        
    var body: some View {
        VStack {
            RoundedRectangleImage(image: Image("ella-olsson-6UxD0NzDywI-unsplash"))
                .frame(width: 160, height: 160)
                .aspectRatio(contentMode: .fit)
            
            Text("SomeRecipe")
        }
    }
}

struct HomeApiItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeApiRecipeCard()
    }
}
