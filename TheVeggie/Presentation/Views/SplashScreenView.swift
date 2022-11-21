//
//  Project: TheVeggie
//  SplashScreen.swift
//
//
//  Created by Jessica Ernst on 21.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct SplashScreenView: View {
    
    @State var isActive = false
    @State private var size = 0.2
    @State private var opacity = 0.2
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                backgroundGradient
                    .ignoresSafeArea()
                VStack {
                    VStack {
                        Image("vegetables")
                        
                        Text("The Veggie")
                            .font(Font.custom("Gill Sans UltraBold", size: 34))
                            .foregroundColor(.primary.opacity(0.80))
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
