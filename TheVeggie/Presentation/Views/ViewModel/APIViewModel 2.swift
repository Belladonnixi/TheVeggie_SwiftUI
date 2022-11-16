//
//  Project: TheVeggie
//  HomeAPIViewModel.swift
//
//
//  Created by Jessica Ernst on 21.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import Combine
import SwiftUI
import WebKit

class ApiViewmodel: ObservableObject {
    
    @Published var dataArray: [Recipe] = []
    var cancellables = Set<AnyCancellable>()

    let dataService = RecipeModelDataService.instance
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$recipes
            .sink { [weak self] (returnedRecipes) in
                self?.dataArray.append(contentsOf: returnedRecipes)
            }
            .store(in: &cancellables)
    }
    
    func loadUrl(urlString: String) {
           guard let url = URL(string: urlString) else {
               return
           }
           webView.load(URLRequest(url: url))
       }
}
