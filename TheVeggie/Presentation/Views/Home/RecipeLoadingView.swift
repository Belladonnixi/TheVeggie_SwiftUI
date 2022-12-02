//
//  Project: TheVeggie
//  RecipeLoadingView.swift
//
//
//  Created by Jessica Ernst on 02.12.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct RecipeLoadingView: View {
    
    @StateObject var vm = RecipeLoadingViewModel()
    
    var body: some View {
        ZStack {
            backgroundGradient.edgesIgnoringSafeArea([.all])
            
            VStack {
                switch vm.state {
                case .loaded(let recipes):
                    HomeAPIView(recipes: recipes)
                        .refreshable {
                            vm.load(refresh: true)
                        }
                case .empty(let message):
                    MessageView(message: message)
                        .refreshable {
                            vm.load(refresh: true)
                        }
                case .error(let message):
                    MessageView(message: message)
                        .refreshable {
                            vm.load(refresh: true)
                        }
                case .loading:
                    ProgressView()
                        .onAppear {
                            vm.load(refresh: true)
                        }
                }
                
                Button {
                    vm.load(refresh: false)
                } label: {
                    HStack {
                        Spacer()
                        Label("load more", systemImage: "square.and.arrow.down")
                        Spacer()
                    }
                    
                }
                .padding(.vertical)
                .frame(width: 150)
                .foregroundColor(Color.white)
                .background(CustomColor.forestGreen)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 7)
                .padding(16)
            }
                
        }
    }
}

struct RecipeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeLoadingView()
    }
}
