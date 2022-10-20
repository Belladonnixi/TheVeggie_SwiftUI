//
//  Project: TheVeggie
//  RoundedRectangleImage.swift
//
//
//  Created by Jessica Ernst on 20.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct RoundedRectangleImage: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .background(Color.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(.teal, lineWidth: 2)
            )
            .shadow(radius: 7)
    }
}

struct RoundedRectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangleImage(image: Image("ella-olsson-6UxD0NzDywI-unsplash"))
    }
}
