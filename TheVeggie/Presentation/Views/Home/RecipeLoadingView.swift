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
        NavigationStack {
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
                        MessageView(message: message, color: Color.gray)
                            .refreshable {
                                vm.load(refresh: true)
                            }
                    case .error(let message):
                        MessageView(message: message, color: Color.red)
                            .refreshable {
                                vm.load(refresh: true)
                            }
                    case .loading:
                        ProgressView()
                            .onAppear {
                                vm.load(refresh: true)
                            }
                    }
                }
                .safeAreaInset(edge: .bottom) {
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
                    .frame(width: 150, height: 48)
                    .foregroundColor(Color.white)
                    .background(CustomColor.forestGreen.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 7)
                    .padding(8)
                }
            }
        }
        
    }
}

struct RecipeLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeLoadingView()
    }
}
