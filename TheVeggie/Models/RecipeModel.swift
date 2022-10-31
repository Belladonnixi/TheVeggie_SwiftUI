//
//  Project: TheVeggie
//  RecipeModel.swift
//
//
//  Created by Jessica Ernst on 20.10.22
//
/// Copyright © 2022 Jessica Ernst. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let from, to, count: Int
    let links: WelcomeLinks
    let hits: [Hit]

    enum CodingKeys: String, CodingKey {
        case from, to, count
        case links = "_links"
        case hits
    }
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe
    let links: HitLinks

    enum CodingKeys: String, CodingKey {
        case recipe
        case links = "_links"
    }
}

// MARK: - HitLinks
struct HitLinks: Codable {
    let linksSelf: SelfClass

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

// MARK: - SelfClass
struct SelfClass: Codable {
    let href: String
    let title: Title
}

enum Title: String, Codable {
    case titleSelf = "Self"
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let images: Images
    let source: String
    let url: String
    let shareAs: String
    let yield: Int
    let ingredients: [Ingredient]
    let totalWeight: Double
    let totalTime: Int
    let cuisineType: [String]
    let mealType: [MealType]
    let dishType: [String]?
}

// MARK: - Images
struct Images: Codable {
    let thumbnail, small, regular: Large
    let large: Large?

    enum CodingKeys: String, CodingKey {
        case thumbnail = "THUMBNAIL"
        case small = "SMALL"
        case regular = "REGULAR"
        case large = "LARGE"
    }
}

// MARK: - Large
struct Large: Codable {
    let url: String
    let width, height: Int
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let text: String
    let quantity: Double
    let measure: String?
    let food: String
    let weight: Double
    let foodCategory: String?
    let foodID: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case text, quantity, measure, food, weight, foodCategory
        case foodID = "foodId"
        case image
    }
}

enum MealType: String, Codable {
    case breakfast = "breakfast"
    case brunch = "brunch"
    case lunchDinner = "lunch/dinner"
    case teatime = "teatime"
    case snack = "snack"
}

// MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
}
