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
    
    func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }    
}
