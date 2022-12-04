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
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    case .empty(let message):
                        MessageView(message: message, color: Color.gray)
                    case .error(let message):
                        MessageView(message: message, color: Color.red)
                    case .loading:
                        Spacer()
                        ProgressView()
                            .onAppear {
                                vm.load(refresh: true)
                            }
                        Spacer()
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    Button {
                        vm.load(refresh: false)
                    } label: {
                        HStack {
                            Spacer()
                            Label("load more", systemImage: "square.and.arrow.down")
                                .font(.system(size: 16, weight: .semibold))
                            Spacer()
                        }
                    }
                    .padding(.vertical)
                    .foregroundColor(CustomColor.forestGreen)
                    .background(.clear)
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
