//
//  Project: TheVeggie
//  MessageView.swift
//
//
//  Created by Jessica Ernst on 02.12.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct MessageView: View {
    var message: String
    var color: Color
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(message)
                .foregroundColor(color)
            
            Spacer()
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        let message = "test error errror error"
        let color = Color.red
        MessageView(message: message, color: color)
    }
}
