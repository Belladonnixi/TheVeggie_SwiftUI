//
//  Project: TheVeggie
//  ImageModelCacheManager.swift
//
//
//  Created by Jessica Ernst on 31.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//


import Foundation
import SwiftUI

class RecipeImageModelCacheManager {
    
    static let instance = RecipeImageModelCacheManager()
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200 // 200mb
        return cache
    }()
    
    func add(key: String, value: UIImage) {
        imageCache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
}
