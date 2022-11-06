//
//  Project: TheVeggie
//  RectangleImage.swift
//
//
//  Created by Jessica Ernst on 06.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct RectangleImage: View {
    
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .background(Color.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 2)
            )
            .shadow(radius: 7)
    }
}

struct RectangleImage_Previews: PreviewProvider {
    static var previews: some View {
        RectangleImage(image: Image(systemName: "photo.artframe"))
    }
}
