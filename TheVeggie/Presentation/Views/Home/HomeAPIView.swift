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
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    @StateObject var vm = ApiWebViewViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Gill Sans UltraBold", size: 34)!]
    }
    
    var body: some View {
        
        NavigationView {
            
            ScrollViewReader { proxyReader in
                
                ZStack {
                    backgroundGradient.edgesIgnoringSafeArea([.all])
                    
                    ScrollView(.vertical, showsIndicators: false, content:  {
                        
                        _HSpacer(minWidth: 16)
                        
                        VStack(spacing: 16) {
                            ForEach(vm.dataArray, id: \.label) { model in
                                NavigationLink {
                                    ApiRecipeDetailView(recipe: model)
                                } label: {
                                    HomeApiRecipeRow(recipe: model)
                                }
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
                            .frame(width: 150)
                            .foregroundColor(Color.white)
                            .background(CustomColor.forestGreen)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 7)
                            .padding(16)
                        }
                        .padding()
                        .id("TOP")
                        .overlay(
                            // getting ScrollView Offset using GeometryRadar
                            GeometryReader { proxy -> Color in
                                
                                DispatchQueue.main.async {
                                    if startOffset == 0 {
                                        self.startOffset = proxy.frame(in: .global).minY
                                    }
                                    
                                    let offset = proxy.frame(in: .global).minY
                                    self.scrollViewOffset = offset - startOffset
                                }
                                
                                return Color.clear
                            }
                                .frame(width: 0, height: 0)
                            ,alignment: .top
                        )
                    })
                    .navigationBarTitleDisplayMode(.automatic)
                    .navigationTitle("The Veggie")
                    .overlay(
                        Button {
                            withAnimation(.spring()) {
                                proxyReader.scrollTo("TOP", anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                                .padding()
                                .background(.orange)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                            .padding(.trailing)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                            .opacity(-scrollViewOffset > 450 ? 1 : 0)
                            .animation(.easeInOut, value: 1)
                        ,alignment: .bottomTrailing
                    )
                }
            }
        }
    }
}

struct HomeAPIView_Previews: PreviewProvider {
    static var previews: some View {
        HomeAPIView()
    }
}
