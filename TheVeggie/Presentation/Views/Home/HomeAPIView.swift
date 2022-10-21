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
    
    @State var searchQuery = ""
    @StateObject var vm = HomeApiViewmodel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    
//                        VStack {
//                            RoundedRectangleImage(image: Image("ella-olsson-6UxD0NzDywI-unsplash"))
//                                .frame(width: 160, height: 160)
//                                .aspectRatio(contentMode: .fit)
                            
                            Text(model.label!)
                        
//                    }
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("The Veggie")
        }
        .searchable(text: $searchQuery)
    }
}

struct HomeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAPIView()
    }
}
