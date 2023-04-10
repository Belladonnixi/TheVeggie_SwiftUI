//
//  Project: TheVeggie
//  Container.swift
//
//
//  Created by Jessica Ernst on 28.03.23
//
/// Copyright © 2023 Jessica Ernst. All rights reserved.
//


import Foundation
import Factory

extension Container {
    var apiViewModel: Factory<ApiWebViewViewModel> {
        self { ApiWebViewViewModel() }
    }
    
    var imageLoadingViewModel: Factory<ImageLoadingViewModel> {
        self { ImageLoadingViewModel(url: "", key: "")}
    }
    
    
}
