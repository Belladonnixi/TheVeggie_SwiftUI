//
//  Project: TheVeggie
//  RecipeWebView.swift
//
//
//  Created by Jessica Ernst on 03.11.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import SwiftUI
import WebKit

struct RecipeWebView: UIViewRepresentable {
        
    typealias UIViewType = WKWebView
    
    let webView: WKWebView
    
    init() {
        webView = WKWebView(frame: .zero)
        webView.load(URLRequest(url: URL(string: "https://www.taste.com.au/recipes/lentils-crispy-brussel-sprouts-roasted-mushroom/782c78fa-d9b9-4505-b876-e3d6667b8b7e")!))
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
}
