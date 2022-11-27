//
//  Project: TheVeggie
//  HomeAPIView.swift
//
//
//  Created by Jessica Ernst on 18.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI

struct HomeAPIView: View {
    
    @StateObject var vm = ApiWebViewViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content:  {
                VStack(spacing: 16) {
                    ForEach(vm.dataArray, id: \.label) { model in
                        NavigationLink {
                            ApiRecipeDetailView(recipe: model)
                        } label: {
                            HomeApiRecipeRow(recipe: model)
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                    
                    Button {
                        vm.dataService.downloadData()
                    } label: {
                        HStack {
                            Spacer()
                            Label("load more", systemImage: "square.and.arrow.down")
                            Spacer()
                        }
                        
                    }
                    .padding(.vertical)
                    .foregroundColor(Color.white)
                    .background(CustomColor.forestGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 7)
                    .padding(16)
                }
            })
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("The Veggie")
            .background(backgroundGradient)
        }
    }
}

struct HomeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAPIView()
    }
}
